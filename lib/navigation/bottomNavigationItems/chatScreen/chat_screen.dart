import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_soko/common/utils.dart';
import 'package:m_soko/navigation/bottomNavigationItems/chatScreen/chat_buble.dart';
import 'package:m_soko/navigation/bottomNavigationItems/chatScreen/chat_screen_controller.dart';

class ChatScreen extends StatelessWidget {
  final String sellerUserEmail;
  final String sellerUserID;
  final String sellerUserName;

  const ChatScreen({
    super.key,
    required this.sellerUserEmail,
    required this.sellerUserID,
    required this.sellerUserName,
  });

  @override
  Widget build(BuildContext context) {
    final ChatScreenController controller = Get.put(ChatScreenController());
    return WillPopScope(
      onWillPop: controller.onWillPop,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(sellerUserName),
          ),
          body: GetBuilder<ChatScreenController>(
            builder: (_) => Container(
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
                      child: _buildMessageList(controller),
                    ),
                  ),
                  _buildMessageInput(controller),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Build Message List
  Widget _buildMessageList(ChatScreenController controller) {
    return StreamBuilder(
      stream: controller.chatService.getMessages(
        controller.currentUserEmail,
        sellerUserEmail,
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
          controller: controller.scrollController,
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            return _buildMessageItem(controller, snapshot.data!.docs[index]);
          },
        );
      },
    );
  }

  // Build Message item
  _buildMessageItem(
      ChatScreenController controller, DocumentSnapshot document) {
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
            isBuyer: data['buyerEmail'] == controller.currentUserEmail,
            timeAgo: timeAgo,
          ),
        );

      case 1: // banner
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.0),
          child: BannerChatBubble(
            imageUrl: data['imageUrl'],
            message: data['message'],
            isBuyer: data['buyerEmail'] == controller.currentUserEmail,
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
            isBuyer: data['buyerEmail'] == controller.currentUserEmail,
            timeAgo: timeAgo,
            orderQuantity: data['orderQuantity'],
            orderDeliveryCharge: (data['deliveryCharge'] as num?)!.toDouble(),
          ),
        );

      default:
        log('case def');
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.0),
          child: ChatBubble(
            message: data['message'],
            isBuyer: data['buyerEmail'] == controller.currentUserEmail,
            timeAgo: timeAgo,
          ),
        );
    }
  }

  // buil message input
  Widget _buildMessageInput(ChatScreenController controller) {
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
                  controller: controller.messageController,
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
                  onPressed: () => controller.sendMessage,
                  icon: const Icon(
                    Icons.attachment_outlined,
                    size: 30,
                  ),
                ),
              ),
            ),
          ),
          if (controller.isLoading.value)
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Utils.customLoadingSpinner(),
            )
          else
            Material(
              borderRadius: BorderRadius.circular(50),
              elevation: 5,
              child: IconButton(
                onPressed: () => controller.sendMessage(
                  sellerUserID,
                  sellerUserEmail,
                  sellerUserName,
                ),
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
}
