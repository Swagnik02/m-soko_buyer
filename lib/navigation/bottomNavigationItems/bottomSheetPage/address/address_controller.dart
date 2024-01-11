import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:m_soko/common/utils.dart';
import 'package:m_soko/models/user_model.dart';

class AddressController extends GetxController {
  late BuildContext context;
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
    Fluttertoast.showToast(msg: 'Use a unique name !!');
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
      UserModel updatedUserData = getUserDataFromEditedValues();
      await UserDataService().updateUserData(updatedUserData);
    } else {
      log('Name and address cannot be empty.');
    }
  }

  // delete address logic
  Future<void> removeEntry(String key) async {
    bool confirmDelete = await showConfirmationDialog(context);

    if (confirmDelete) {
      try {
        addressLinesMap.remove(key);
        update();

        String email = UserDataService().userModel!.email;
        await FirebaseFirestore.instance
            .collection(FirestoreCollections.usersCollection)
            .doc(email)
            .update({
          'addressLines': addressLinesMap,
        });

        UserModel updatedUserData = getUserDataFromEditedValues();
        await UserDataService().updateUserData(updatedUserData);
        Fluttertoast.showToast(msg: 'Address removed');
      } catch (error) {
        log('Error removing address: $error');
      }
    }
  }

  // Edit address

  onTapEditAddress(String key) {
    TextEditingController descriptionController =
        TextEditingController(text: addressLinesMap[key]);
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return _editAddressDialogue(
          key,
          descriptionController,
          () async {
            // update locally
            addressLinesMap[key] = descriptionController.text;
            update();
            // update in firebase
            await addAddressToFirestore(addressLinesMap);

            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  Widget _editAddressDialogue(
    String key,
    TextEditingController descriptionController,
    VoidCallback onTapAction,
  ) {
    return AlertDialog(
      title: Text(key),
      content: TextField(
        controller: descriptionController,
        decoration: const InputDecoration(labelText: 'New Description'),
        maxLines: null,
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: onTapAction,
          child: const Text('Save'),
        ),
      ],
    );
  }

  UserModel getUserDataFromEditedValues() {
    Map<String, dynamic> updatedaddressLinesMap = addressLinesMap;

    return UserModel(
      addressLines: updatedaddressLinesMap,

      // pre-existing data
      userName: UserDataService().userModel!.userName,
      country: UserDataService().userModel!.country,
      pin: UserDataService().userModel!.pin,
      city: UserDataService().userModel!.city,
      mobile: UserDataService().userModel!.mobile,
      state: UserDataService().userModel!.state,
      email: UserDataService().userModel!.email,
    );
  }
}
