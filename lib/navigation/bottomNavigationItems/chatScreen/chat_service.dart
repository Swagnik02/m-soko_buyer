import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:m_soko/common/utils.dart';
import 'package:m_soko/models/product_model.dart';
import 'package:m_soko/models/user_model.dart';
import 'package:m_soko/navigation/bottomNavigationItems/chatScreen/message_model.dart';

class MessageType {
  static const int normaltext = 0;
  static const int banner = 1;
}

class ChatService extends ChangeNotifier {
  // get instance of auth and firestore
  // final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // SEND MESSAGE
  Future<void> sendMessage(
    String sellerId,
    String sellerEmail,
    String sellerUsername,
    String message,
    int? msgType,
    ProductModel? productModel,
  ) async {
    // get current user info
    final String currentUserId = UserDataService().userModel!.uid.toString();
    final String currentUserEmail =
        UserDataService().userModel!.email.toString();
    final Timestamp timestamp = Timestamp.now();

    // create a new message
    Message newMessage = Message(
      productId: productModel?.productId ?? '',
      buyerId: currentUserId,
      buyerEmail: currentUserEmail,
      sellerId: sellerId,
      sellerEmail: sellerEmail,
      message: message,
      timestamp: timestamp,

      //
      imageUrl: productModel?.itemThumbnail ?? '',
      messageType: msgType ?? 0,
    );

    // construct a chatroom Id from current user id and seller id (sorted to ensure uniqueness)
    List<String> ids = [currentUserEmail, sellerEmail];
    ids.sort(); // ensures the chat room id will same for any two people
    String chatRoomId = ids.join("_");
    // log(chatRoomId);

    // add new message to database
    final existingDoc = await _firestore
        .collection(FirestoreCollections.productsChatRoom)
        .doc(chatRoomId)
        .get();
    if (!existingDoc.exists) {
      await _firestore
          .collection(FirestoreCollections.productsChatRoom)
          .doc(chatRoomId)
          .set({
        'chatRoomId': chatRoomId,
        'buyerEmail': currentUserEmail,
        'sellerEmail': sellerEmail,
        'sellerId': sellerId,
        'sellerUsername': sellerUsername,
      });
    }

    // add new message to database
    await _firestore
        .collection(FirestoreCollections.productsChatRoom)
        .doc(chatRoomId)
        .collection('messages')
        .add(newMessage.toMap());
  }

  // using emailId
  Stream<QuerySnapshot> getMessages(
      String currentUserEmail, String otherUserEmail) {
    // construct chatroom id from user ids
    List<String> ids = [currentUserEmail, otherUserEmail];
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
