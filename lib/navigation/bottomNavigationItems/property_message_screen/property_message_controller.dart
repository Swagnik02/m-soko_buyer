import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:m_soko/common/utils.dart';
import 'package:m_soko/models/property_message_models.dart';

class PropertyMessageController extends GetxController {
  final TextEditingController messageController = TextEditingController();


  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> sendMessage(
      String agentId, String agentEmail, String agentName) async {
    if (messageController.text.isNotEmpty) {
      await _sendMessageService(
          agentId, agentEmail, agentName, messageController.text);
      messageController.clear();
    }
  }

  Future<void> _sendMessageService(String agentId, String agentEmail,
      String agentName, String message) async {
    final currentUser = firebaseAuth.currentUser!.uid;
    final currentUserEmail = firebaseAuth.currentUser!.email;
    final Timestamp timestamp = Timestamp.now();

    PropertyMessageModel newMessage = PropertyMessageModel(
      buyerId: currentUser,
      buyerEmail: currentUserEmail.toString(),
      agentId: agentId,
      agentEmail: agentEmail,
      message: message,
      timestamp: timestamp,
    );

    List<String> ids = [currentUser, agentId];
    ids.sort();
    String chatRoomId = ids.join("_");

    final existData =
        await firestore.collection('propertyChatRoom').doc(chatRoomId).get();

    if (!existData.exists) {
      await firestore.collection('propertyChatRoom').doc(chatRoomId).set({
        "chatRoomId": chatRoomId,
        "buyerEmail": currentUserEmail,
        "agentId": agentId,
        "agentEmail": agentEmail,
        "agentName": agentName,
      });
    }
    await Utils.saveColorToPrefs();

    await firestore
        .collection('propertyChatRoom')
        .doc(chatRoomId)
        .collection('messages')
        .add(newMessage.toJson());
  }

  Stream<QuerySnapshot> getMessages(String currentUserId, String agentUserId) {
    List<String> ids = [currentUserId, agentUserId];
    ids.sort();
    String chatRoomId = ids.join("_");
    return firestore
        .collection('propertyChatRoom')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }

  Future uploadDataToFirebase({
    required String roomID,
    required String currentEmail,
    required String receiverEmail,
    required String receiverName,
    required String currentName,
    required String userType,
    required TextEditingController controller,
  }) async {
    if (roomID == "blank") {
      DocumentReference<Map<String, dynamic>> newChatRoomRef =
          FirebaseFirestore.instance.collection('chatrooms').doc();
      await newChatRoomRef.set({
        'Last Message': "",
        'Participants': [
          currentEmail,
          receiverEmail,
        ],
      }).then((value) {
        roomID = newChatRoomRef.id;
        update();
      });
      String x = controller.text;
      controller.text = "";
      await FirebaseFirestore.instance
          .collection('chatrooms')
          .doc(roomID)
          .collection('messages')
          .doc('${DateTime.now().millisecondsSinceEpoch}')
          .set({
        'Date': DateTime.now(),
        'Seen': "False",
        'Sender': currentEmail,
        'Text': x,
        'Type': "message",
      });
      await FirebaseFirestore.instance
          .collection('Buyers')
          .doc(currentEmail)
          .collection('Chat History')
          .doc(receiverEmail)
          .set({
        'Last Message Date': DateTime.now(),
        'Last Message': x,
        'Sender': receiverName,
        'User Type': userType,
      });
      await FirebaseFirestore.instance
          .collection((userType == "Seller") ? "users" : "Agents")
          .doc(receiverEmail)
          .collection('Chat History')
          .doc(currentEmail)
          .set({
        'Last Message Date': DateTime.now(),
        'Last Message': x,
        'Sender': currentName,
        'User Type': 'Buyers'
      });
    } else if (roomID != "") {
      String x = controller.text;
      controller.text = "";
      await FirebaseFirestore.instance
          .collection('chatrooms')
          .doc(roomID)
          .collection('messages')
          .doc('${DateTime.now().millisecondsSinceEpoch}')
          .set({
        'Date': DateTime.now(),
        'Seen': "False",
        'Sender': currentEmail,
        'Text': x,
        'Type': "message",
      });
      await FirebaseFirestore.instance
          .collection('Buyers')
          .doc(currentEmail)
          .collection('Chat History')
          .doc(receiverEmail)
          .update({
        'Last Message Date': DateTime.now(),
        'Last Message': x,
      });
      await FirebaseFirestore.instance
          .collection((userType == "Seller") ? "users" : "Agents")
          .doc(receiverEmail)
          .collection('Chat History')
          .doc(currentEmail)
          .update({
        'Last Message Date': DateTime.now(),
        'Last Message': x,
      });
    }
  }
}
