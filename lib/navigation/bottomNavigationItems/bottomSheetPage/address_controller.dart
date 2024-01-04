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

  Map<String, dynamic> addressLinesMap =
      UserDataService().userModel?.addressLines ?? {};

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

  // handeling index
  void updateEditAddressIndex() {
    editAddressIndex = !editAddressIndex;
    update();
  }

  // add Address whole process
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

  // delete address logic
  void removeEntry(String key) async {
    addressLinesMap.remove(key);
    update();
  }
}
