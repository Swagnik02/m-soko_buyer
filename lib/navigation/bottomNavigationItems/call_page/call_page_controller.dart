import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class CallPageController extends GetxController {
  final currentUser = FirebaseAuth.instance.currentUser;

  Stream<QuerySnapshot<Map<String, dynamic>>>? getCallHistoryFromFirebase() {
    try {
      return FirebaseFirestore.instance
          .collection('Buyers')
          .doc(currentUser?.email)
          .collection('Call History')
          .orderBy('Date-Time', descending: true)
          .snapshots();
    } on FirebaseFirestore catch (e) {
      log(e.toString());
    }
    return null;
  }
}
