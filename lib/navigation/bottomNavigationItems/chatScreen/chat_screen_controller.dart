import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_soko/models/user_model.dart';
import 'package:m_soko/navigation/bottomNavigationItems/chatScreen/chat_service.dart';

class ChatScreenController extends GetxController {
  final String currentUserId = UserDataService().userModel!.uid.toString();
  final String currentUserEmail = UserDataService().userModel!.email.toString();

  final TextEditingController messageController = TextEditingController();
  final ChatService chatService = ChatService();
  final ScrollController scrollController = ScrollController();

  var isLoading = false.obs;

  // inits
  @override
  void onInit() {
    super.onInit();
    // Delay the scroll to the bottom to allow time for the ListView to build
    _scrollToBottom();
  }

  // scrolling function
  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 500), () {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  // send message
  void sendMessage(
    String sellerUserID,
    String sellerUserEmail,
    String sellerUserName,
  ) async {
    if (messageController.text.isNotEmpty) {
      isLoading(true);
      update();
      await chatService.sendMessage(
        sellerUserID,
        sellerUserEmail,
        sellerUserName,
        messageController.text,
        MessageType.normaltext,
        null,
      );

      messageController.clear();
      _scrollToBottom();
      isLoading(false);
      update();
    }
  }

  Future<bool> onWillPop() async {
    Get.back();
    Get.delete<ChatScreenController>();

    return true;
  }
}
