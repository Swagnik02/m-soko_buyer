import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  void updateAddAddressIndex() {
    addAddressIndex = !addAddressIndex;
    update();
  }

  void updateisLoadingIndex() {
    isLoading = !isLoading;
    update();
  }

  void updateEditAddressIndex() {
    editAddressIndex = !editAddressIndex;
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
      // await Future.delayed(Duration(seconds: 2));

      await addAddressToFirestore(name, address);

      // // UserModel updatedUserData = getUserDataFromEditedValues();
      // // await UserDataService().updateUserData(updatedUserData);
      updateisLoadingIndex();
      updateAddAddressIndex();
      addAddressController.clear();
      addReceipentNameController.clear();

      Fluttertoast.showToast(msg: 'Address added');
    } catch (error) {
      Fluttertoast.showToast(msg: 'Error updating profile: $error');
      updateisLoadingIndex();
    }
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

  Future<void> addAddressToFirestore(String name, String address) async {
    String email = UserDataService().userModel!.email;
    // Ensure that both name and address are not empty before proceeding
    if (name.isNotEmpty && address.isNotEmpty) {
      // Get the Firestore instance and add the address to the collection
      await FirebaseFirestore.instance
          .collection(FirestoreCollections.usersCollection)
          .doc(email)
          .update({
        'addressLines.addressLine1': FieldValue.arrayUnion([name, address]),
      });
    } else {
      // Handle the case where either name or address is empty
      print('Name and address cannot be empty.');
    }
  }

  UserModel getUserDataFromEditedValues() {
    return UserModel(
      email: UserDataService().userModel!.email,
    );
  }
}
