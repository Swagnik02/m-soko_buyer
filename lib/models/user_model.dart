import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  String get userId => FirebaseAuth.instance.currentUser?.uid ?? 'userid007';

  String get userName =>
      FirebaseAuth.instance.currentUser?.displayName ?? 'user';

  String get email =>
      FirebaseAuth.instance.currentUser?.email ?? 'user@email.com';

  String get mobile =>
      FirebaseAuth.instance.currentUser?.phoneNumber ?? '+27 9034566774';

  String city = 'Kolkata';
  String pin = '731303';
  String state = 'West Bengal';
  String country = 'India';

  Future<void> fetchUserData() async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> userDoc =
          await FirebaseFirestore.instance
              .collection('users')
              .doc(userId)
              .get();

      if (userDoc.exists) {
        // Assuming you have fields like 'city', 'pin', 'state', 'country' in your document
        // Adjust this based on your actual data structure
        city = userDoc['city'] ?? 'Kolkata';
        pin = userDoc['pin'] ?? '731303';
        state = userDoc['state'] ?? 'West Bengal';
        country = userDoc['country'] ?? 'India';
      }
    } catch (e) {
      // Handle error appropriately
      log('Error fetching user data: $e');
    }
  }
}
