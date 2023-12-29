import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:m_soko/common/utils.dart';
import 'package:m_soko/models/user_model.dart';
import 'package:m_soko/navigation/bottomNavigationItems/chatScreen/chat_screen.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  final String currentUserId = UserDataService().userModel!.uid.toString();
  final String currentUserEmail = UserDataService().userModel!.email.toString();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildUserList(),
    );
  }

  // buld a list of sellers
  Widget _buildUserList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection(FirestoreCollections.productsChatRoom)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Error');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Utils.customLoadingSpinner(),
          );
        }
        return ListView(
          children: snapshot.data!.docs
              .map<Widget>((doc) => _buildUserListItem(doc))
              .toList(),
        );
      },
    );
  }

// build individual chat list items
  Widget _buildUserListItem(DocumentSnapshot document) {
    Map<String, dynamic> chatRoom = document.data() as Map<String, dynamic>;

    if (chatRoom['buyerEmail'] == currentUserEmail) {
      String sellerEmail = chatRoom['sellerEmail'];
      String sellerId = chatRoom['sellerId'];
      String sellerUsername = chatRoom['sellerUsername'];

      return ListTile(
        title: Text(sellerUsername),
        onTap: () {
          // pass the clicked users uid to the chat page
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatScreen(
                sellerUserEmail: sellerEmail,
                sellerUserID: sellerId,
                sellerUserName: sellerUsername,
              ),
            ),
          );
        },
      );
    } else {
      // If buyerEmail doesn't match, return an empty container or null
      return Container(); // or return null;
    }
  }
}
