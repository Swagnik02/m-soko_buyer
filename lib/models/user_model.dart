import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:m_soko/common/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserModel {
  String? userName;
  String email;
  String? country;
  String? uid;
  String? pin;
  String? city;
  String? mobile;
  String? state;
  Map<String, List<String>>? addressLines;

  UserModel({
    this.userName,
    required this.email,
    this.country,
    this.uid,
    this.pin,
    this.city,
    this.mobile,
    this.state,
    this.addressLines,
  });

  // Add any other methods or properties you need
}

class UserDataService {
  static final UserDataService _instance = UserDataService._internal();

  factory UserDataService() {
    return _instance;
  }

  UserDataService._internal();

  UserModel? _userModel;

  UserModel? get userModel => _userModel;
  Future<void> fetchUserData(String userEmail) async {
    try {
      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        // User not authenticated
        return;
      }

      String userEmail = currentUser.email ?? "";
      if (userEmail.isEmpty) {
        // Email not available
        return;
      }

      CollectionReference usersCollection = FirebaseFirestore.instance
          .collection(FirestoreCollections.usersCollection);
      QuerySnapshot querySnapshot =
          await usersCollection.where('email', isEqualTo: userEmail).get();

      if (querySnapshot.docs.isNotEmpty) {
        for (QueryDocumentSnapshot productDocument in querySnapshot.docs) {
          Map<String, dynamic> userData =
              productDocument.data() as Map<String, dynamic>;

          _userModel = UserModel(
            country: userData['country']?.toString() ?? '',
            uid: userData['uid']?.toString() ?? '',
            pin: userData['pin']?.toString() ?? '',
            city: userData['city']?.toString() ?? '',
            mobile: userData['mobile']?.toString() ?? '',
            state: userData['state']?.toString() ?? '',
            userName: userData['userName']?.toString() ?? '',
            email: userData['email']?.toString() ?? '',
            addressLines: (userData['addressLines'] as Map<String, dynamic>?)
                    ?.map((key, value) {
                  if (value is List<dynamic>) {
                    return MapEntry(key, value.cast<String>());
                  } else {
                    return MapEntry(key, <String>[]);
                  }
                }) ??
                {},
          );

          log('Users Data for $userEmail: $userData');
        }
      } else {
        // User not found
        _userModel = null;
      }
    } catch (e) {
      // Handle specific Firestore exceptions
      log('Error collecting user data: $e');
    }
  }

  void storeUserDataLocally() {
    if (_userModel != null) {
      SharedPreferences.getInstance().then((prefs) {
        prefs.setString('user_email', _userModel!.email);
        prefs.setString('user_name', _userModel?.userName ?? '');
        prefs.setString('country', _userModel?.country ?? '');
        prefs.setString('uid', _userModel?.uid ?? '');
        prefs.setString('pin', _userModel?.pin ?? '');
        prefs.setString('city', _userModel?.city ?? '');
        prefs.setString('mobile', _userModel?.mobile ?? '');
        prefs.setString('state', _userModel?.state ?? '');
        prefs.setString(
          'addressLines',
          _userModel?.addressLines?.toString() ?? '',
        );
      });
    }
  }

  // Add a method to retrieve user data from local storage
  Future<void> retrieveUserDataLocally() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userEmail = prefs.getString('user_email') ?? "";
    if (userEmail.isNotEmpty) {
      await fetchUserData(userEmail);
    }
  }

  Future<void> updateUserData(UserModel updatedUserData) async {
    try {
      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        // User not authenticated
        return;
      }

      String userEmail = currentUser.email ?? "";
      if (userEmail.isEmpty) {
        // Email not available
        return;
      }

      CollectionReference usersCollection = FirebaseFirestore.instance
          .collection(FirestoreCollections.usersCollection);
      await usersCollection.doc(userEmail).update({
        'country': updatedUserData.country,
        // 'uid': updatedUserData.uid,
        'pin': updatedUserData.pin,
        'city': updatedUserData.city,
        'mobile': updatedUserData.mobile,
        'state': updatedUserData.state,
        'userName': updatedUserData.userName,
        // 'email': updatedUserData.email,
      });

      // Update local data
      _userModel = updatedUserData;
      storeUserDataLocally();

      // Retrieve updated user data locally
      await retrieveUserDataLocally();
    } catch (e) {
      // Handle specific Firestore exceptions
      log('Error updating user data: $e');
    }
  }

  Future<void> updateAddressData(UserModel updatedUserData) async {
    try {
      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        // User not authenticated
        return;
      }

      String userEmail = currentUser.email ?? "";
      if (userEmail.isEmpty) {
        // Email not available
        return;
      }

      CollectionReference usersCollection = FirebaseFirestore.instance
          .collection(FirestoreCollections.usersCollection);
      await usersCollection.doc(userEmail).update({
        'addressLines'
            'country': updatedUserData.country,
        // 'uid': updatedUserData.uid,
        'pin': updatedUserData.pin,
        'city': updatedUserData.city,
        'mobile': updatedUserData.mobile,
        'state': updatedUserData.state,
        'userName': updatedUserData.userName,
        // 'email': updatedUserData.email,
      });

      // Update local data
      _userModel = updatedUserData;
      storeUserDataLocally();

      // Retrieve updated user data locally
      await retrieveUserDataLocally();
    } catch (e) {
      // Handle specific Firestore exceptions
      log('Error updating user data: $e');
    }
  }

  Future<void> clearUserDataLocally() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    _userModel = null;
  }

  Future<void> addAddressToFirestore(
      Map<String, dynamic> newAddressLine) async {
    String email = UserDataService().userModel!.email;
    // Ensure that both name and address are not empty before proceeding
    if (newAddressLine.isNotEmpty) {
      // Get the Firestore instance and add the address to the collection
      await FirebaseFirestore.instance
          .collection(FirestoreCollections.usersCollection)
          .doc(email)
          .update(newAddressLine);
    } else {
      print('Name and address cannot be empty.');
    }
  }
}
