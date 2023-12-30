import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_soko/common/utils.dart';
import 'package:m_soko/models/user_model.dart';
import 'package:m_soko/navigation/bottomNavigationItems/property_message_screen/property_message_screen.dart';

class PropertyMessageList extends StatelessWidget {
  PropertyMessageList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildUserList(),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder<QuerySnapshot>(
      stream:
          FirebaseFirestore.instance.collection('propertyChatRoom').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Error');
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Utils.customLoadingSpinner(),
          );
        } else if (!snapshot.hasData) {
          return const Text('No Text Yet...');
        }

        return ListView(
          children: snapshot.data!.docs
              .map<Widget>((doc) => _buildUserListItem(doc))
              .toList(),
        );
      },
    );
  }

  Widget _buildUserListItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    if (data['buyerEmail'] == UserDataService().userModel!.email) {
      String agentEmail = data['agentEmail'];
      String agentId = data['agentId'];
      String agentName = data['agentName'];
      final first = agentName.split(',').elementAt(0);

      return ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.green,
          child: Text(
            first[0],
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        title: Text(
          agentName,
          style: const TextStyle(),
        ),
        onTap: () {
          Get.to(const PropertyMessageScreen(), arguments: {
            "agentId": agentId,
            "agentEmail": agentEmail,
            "agentName": agentName,
          });
        },
      );
    } else {
      return Container();
    }
  }
}
