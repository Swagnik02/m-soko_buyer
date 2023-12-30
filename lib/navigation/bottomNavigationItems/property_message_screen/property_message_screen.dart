import 'dart:developer';

import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_soko/common/colors.dart';
import 'package:m_soko/common/utils.dart';
import 'package:m_soko/models/property_message_models.dart';
import 'package:m_soko/navigation/bottomNavigationItems/property_message_screen/property_message_controller.dart';

class PropertyMessageScreen extends StatelessWidget {
  const PropertyMessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PropertyMessageController());
    final propertiesId = Get.arguments as Map<String, dynamic>;
    return Scaffold(
      backgroundColor: ColorConstants.bgColour,
      appBar: AppBar(
        backgroundColor: ColorConstants.green700,
        title: Text(propertiesId['agentName'] ?? ''),
      ),
      body: Column(
        children: [
          Expanded(child: _buildMessageList(controller, propertiesId)),
          _buildTextField(
            controller.messageController,
            () {
              controller.sendMessage(
                propertiesId["agentId"],
                propertiesId['agentEmail'],
                propertiesId['agentName'],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMessageList(
      PropertyMessageController controller, propertyModel) {
    return StreamBuilder(
        stream: controller.getMessages(
            propertyModel['agentId'], controller.firebaseAuth.currentUser!.uid),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Something goes wrong');
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Utils.customLoadingSpinner();
          }
          return ListView(
            reverse: true,
            padding: const EdgeInsets.only(bottom: 12),
            children: snapshot.data!.docs
                .map((e) => _buildMessageItem(e, controller))
                .toList(),
          );
        });
  }

  Widget _buildMessageItem(
      DocumentSnapshot doc, PropertyMessageController controller) {
    PropertyMessageModel data =
        PropertyMessageModel.fromJson(doc.data() as Map<String, dynamic>);

    bool isSender = (data.buyerId == FirebaseAuth.instance.currentUser!.uid);

    return BubbleSpecialOne(
      text: data.message,
      isSender: isSender,
      color: Colors.grey,
      textStyle: const TextStyle(
        color: Colors.black,
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, Function onTap) {
    return Padding(
      padding: const EdgeInsets.all(8.0).copyWith(left: 14),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: TextField(
                controller: controller,
                decoration: const InputDecoration(
                  hintText: "Enter text...",
                  contentPadding: EdgeInsets.symmetric(horizontal: 12),
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          InkWell(
            onTap: () => onTap(),
            child: const CircleAvatar(
              backgroundColor: Colors.indigo,
              child: Center(child: Icon(Icons.send, color: Colors.white)),
            ),
          )
        ],
      ),
    );
  }
}
