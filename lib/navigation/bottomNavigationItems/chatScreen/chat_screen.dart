import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:m_soko/common/utils.dart';
import 'package:m_soko/models/user_model.dart';
import 'package:m_soko/navigation/bottomNavigationItems/chatScreen/chat_service.dart';

class ChatPage extends StatefulWidget {
  final String receiverUserEmail;
  final String receiverUserID;

  ChatPage(
      {super.key,
      required this.receiverUserEmail,
      required this.receiverUserID});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(
          widget.receiverUserID, _messageController.text);

      // clear the controller after sending the message
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.receiverUserEmail),
      ),
      body: Column(children: [
        // messages
        Expanded(
          child: _buildMessageList(),
        ),
        _buildMessageInput(),
      ]),
    );
  }

  // Build Message List

  Widget _buildMessageList() {
    return StreamBuilder(
      stream: _chatService.getMessages(
        widget.receiverUserID,
        UserDataService().userModel!.uid.toString(),
      ),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error${snapshot.error}');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Utils.customLoadingSpinner(),
          );
        }
        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            return _buildMessageItem(snapshot.data!.docs[index]);
          },
        );
      },
    );
  }

  // Build Message item
  _buildMessageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    // Get the timestamp from Firestore
    DateTime timestamp = (data['timestamp'] as Timestamp).toDate();

    // Calculate the time difference
    Duration difference = DateTime.now().difference(timestamp);

    // Format the time difference as "time ago"
    String timeAgo = formatDuration(difference);

    // align to right if the sender is the current user
    var alignment =
        (data['senderId'] == UserDataService().userModel!.uid.toString())
            ? Alignment.centerRight
            : Alignment.centerLeft;

    return Container(
      alignment: alignment,
      child: Column(
        children: [
          Text(data['message']),
          // Text(data['timestamp'].toString()),
          Text(timeAgo),
        ],
      ),
    );
  }

  // buil message input
  Widget _buildMessageInput() {
    return Row(
      children: [
        // textField
        Expanded(
          child: TextField(
            controller: _messageController,
            decoration: InputDecoration(
              hintText: 'Enter Message',
            ),
          ),
        ),

        IconButton(
          onPressed: sendMessage,
          icon: Icon(
            Icons.send,
            size: 40,
          ),
        ),
      ],
    );
  }

  String formatDuration(Duration duration) {
    if (duration.inDays > 0) {
      return '${duration.inDays}d ago';
    } else if (duration.inHours > 0) {
      return '${duration.inHours}h ago';
    } else if (duration.inMinutes > 0) {
      return '${duration.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }
}
