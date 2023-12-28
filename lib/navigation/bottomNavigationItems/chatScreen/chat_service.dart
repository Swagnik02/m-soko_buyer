import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:m_soko/common/utils.dart';
import 'package:m_soko/models/user_model.dart';
import 'package:m_soko/navigation/bottomNavigationItems/chatScreen/message_model.dart';

class ChatService extends ChangeNotifier {
  // get instance of auth and firestore
  // final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // SEND MESSAGE
  Future<void> sendMessage(
      String sellerId, String sellerEmail, String message) async {
    // get current user info
    final String currentUserId = UserDataService().userModel!.uid.toString();
    final String currentUserEmail =
        UserDataService().userModel!.email.toString();
    final Timestamp timestamp = Timestamp.now();

    // create a new message
    Message newMessage = Message(
        buyerId: currentUserId,
        buyerEmail: currentUserEmail,
        sellerId: sellerId,
        sellerEmail: sellerEmail,
        message: message,
        timestamp: timestamp);

    // construct a chatroom Id from current user id and seller id (sorted to ensure uniqueness)
    List<String> ids = [currentUserId, sellerId];
    ids.sort(); // ensures the chat room id will same for any two people
    String chatRoomId = ids.join("_");

    // add new message to database

    await _firestore
        .collection(FirestoreCollections.productsChatRoom)
        .doc(chatRoomId)
        .collection('messages')
        .add(newMessage.toMap());
  }

  // GET MESSAGE
  Stream<QuerySnapshot> getMessages(String userId, String otherUserId) {
    // construct chatroom id from user ids
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join("_");
    return _firestore
        .collection(FirestoreCollections.productsChatRoom)
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }
}
