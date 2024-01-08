import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:m_soko/common/utils.dart';
import 'package:m_soko/models/user_model.dart';
import 'package:m_soko/navigation/bottomNavigationItems/chatScreen/chat_buble.dart';
import 'package:m_soko/navigation/bottomNavigationItems/chatScreen/chat_service.dart';

class ChatScreen extends StatefulWidget {
  final String sellerUserEmail;
  final String sellerUserID;
  final String sellerUserName;

  ChatScreen({
    Key? key,
    required this.sellerUserEmail,
    required this.sellerUserID,
    required this.sellerUserName,
  }) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final String currentUserId = UserDataService().userModel!.uid.toString();
  final String currentUserEmail = UserDataService().userModel!.email.toString();
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final ScrollController _scrollController = ScrollController();

  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(
        widget.sellerUserID,
        widget.sellerUserEmail,
        widget.sellerUserName,
        _messageController.text,
        MessageType.normaltext,
        null,
      );

      _messageController.clear();
      _scrollToBottom();
    }
  }

  @override
  void initState() {
    super.initState();
    // Delay the scroll to the bottom to allow time for the ListView to build
    Future.delayed(const Duration(milliseconds: 500), () {
      _scrollToBottom();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.sellerUserName),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('assets/chat_bg.png'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.25),
              BlendMode.dstATop,
            ),
          ),
        ),
        child: Column(
          children: [
            // messages
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: _buildMessageList(),
              ),
            ),
            _buildMessageInput(),
          ],
        ),
      ),
    );
  }

  // Build Message List
  Widget _buildMessageList() {
    return StreamBuilder(
      stream: _chatService.getMessages(
        currentUserEmail,
        widget.sellerUserEmail,
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
          controller: _scrollController,
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

    // Format the time difference as "time ago"
    DateTime timestamp = (data['timestamp'] as Timestamp).toDate();
    Duration difference = DateTime.now().difference(timestamp);
    String timeAgo = formatDuration(difference);

    // chat is a banner
    int msgType = data['messageType'] ?? false;

    switch (msgType) {
      case 0:
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.0),
          child: ChatBubble(
            message: data['message'],
            isBuyer: data['buyerEmail'] == currentUserEmail,
            timeAgo: timeAgo,
          ),
        );

      case 1: // banner
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.0),
          child: BannerChatBubble(
            imageUrl: data['imageUrl'],
            message: data['message'],
            isBuyer: data['buyerEmail'] == currentUserEmail,
            timeAgo: timeAgo,
          ),
        );
      case 2: // Confirmation
        log('case2');
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.0),
          child: ConfirmationChatBubble(
            productId: data['productId'],
            imageUrl: data['imageUrl'],
            message: data['message'],
            isBuyer: data['buyerEmail'] == currentUserEmail,
            timeAgo: timeAgo,
          ),
        );

      default:
        log('case def');
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.0),
          child: ChatBubble(
            message: data['message'],
            isBuyer: data['buyerEmail'] == currentUserEmail,
            timeAgo: timeAgo,
          ),
        );
    }
  }

  // buil message input
  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.only(
        right: 16.0,
        left: 16.0,
        bottom: 16.0,
      ),
      child: Row(
        children: [
          // textField
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Material(
                borderRadius: BorderRadius.circular(16),
                elevation: 5,
                child: TextField(
                  controller: _messageController,
                  minLines: 1,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(10),
                    hintText: 'Enter Message',
                  ),
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Material(
              borderRadius: BorderRadius.circular(50),
              elevation: 5,
              child: Transform.rotate(
                angle: (45 * 3) * (3.14 / 180), // Specify the angle in radians
                child: IconButton(
                  onPressed: sendMessage,
                  icon: const Icon(
                    Icons.attachment_outlined,
                    size: 30,
                  ),
                ),
              ),
            ),
          ),
          Material(
            borderRadius: BorderRadius.circular(50),
            elevation: 5,
            child: IconButton(
              onPressed: sendMessage,
              icon: const Icon(
                Icons.send,
                size: 30,
              ),
            ),
          ),
        ],
      ),
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

  void _scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeInOut,
    );
  }
}
