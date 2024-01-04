import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:m_soko/common/utils.dart';
import 'package:m_soko/models/user_model.dart';

class AddressController extends GetxController {
  bool addAddressIndex = false;
  bool editAddressIndex = false;
  bool saveAddressIndex = false;
  bool isLoading = false;
  late TextEditingController addressLineController;
  late TextEditingController addAddressController;
  late TextEditingController addReceipentNameController;

  // Map<String, List<String>>? addressLinesMap =
  //

  Map<String, dynamic> addressLinesMap =
      UserDataService().userModel?.addressLines ?? {};
  // late int count = addressLinesMap!.length;

  @override
  void onInit() {
    super.onInit();

    addressLineController = TextEditingController();
    addAddressController = TextEditingController();
    addReceipentNameController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    addAddressController.dispose();
    addReceipentNameController.dispose();
  }

  // handeling index

  void updateAddAddressIndex() {
    addAddressIndex = !addAddressIndex;
    update();
  }

  // handeling index

  void updateisLoadingIndex() {
    isLoading = !isLoading;
    update();
  }

  Future<void> onTapAddNewAddress(
    TextEditingController addReceipentNameController,
    TextEditingController addAddressController,
  ) async {
    String name = addReceipentNameController.text;
    String address = addAddressController.text;
    try {
      updateisLoadingIndex();
      // add entry locally
      Map<String, dynamic> newEntry = {name: address};
      addressLinesMap.addEntries(newEntry.entries);

      log(addressLinesMap.toString());
      // added to firestore
      await addAddressToFirestore(addressLinesMap);

      updateisLoadingIndex();
      updateAddAddressIndex();
      addAddressController.clear();
      addReceipentNameController.clear();

      Fluttertoast.showToast(msg: 'Address added');
    } catch (error) {
      log('Error updating profile: $error');
      updateisLoadingIndex();
    }
  }

  void removeEntry(String key) async {
    addressLinesMap.remove(key);
    await Future.delayed(Duration(seconds: 2));

    update();
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
          .set({
        'addressLines': newAddressLine,
      }, SetOptions(merge: true));
    } else {
      log('Name and address cannot be empty.');
    }
  }

  UserModel getUserDataFromEditedValues() {
    return UserModel(
      email: UserDataService().userModel!.email,
    );
  }

  Future<void> onTapUpdateAddress() async {
    try {
      UserModel updatedUserData = getUserDataFromEditedValues();
      await UserDataService().updateUserData(updatedUserData);
      updateAddAddressIndex();
      Fluttertoast.showToast(msg: 'Profile Updated');
    } catch (error) {
      Fluttertoast.showToast(msg: 'Error updating profile: $error');
    }
  }

  void updateEditAddressIndex() {
    editAddressIndex = !editAddressIndex;
    update();
  }
}
