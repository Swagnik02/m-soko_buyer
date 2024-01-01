import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:m_soko/models/user_model.dart';

class AddressController extends GetxController {
  bool addAddressIndex = false;
  bool editAddressIndex = false;
  var isLoading = false.obs;

  late TextEditingController addressLineController;

  @override
  void onInit() {
    super.onInit();

    addressLineController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void updateAddAddressIndex() {
    addAddressIndex = !addAddressIndex;
    update();
  }

  void updateEditAddressIndex() {
    editAddressIndex = !editAddressIndex;
    update();
  }

  Future<void> onTapAddNewAddress() async {
    try {
      isLoading(true);
      UserModel updatedUserData = getUserDataFromEditedValues();
      await UserDataService().updateUserData(updatedUserData);
      isLoading(false);
      updateAddAddressIndex();
      Fluttertoast.showToast(msg: 'Profile Updated');
    } catch (error) {
      Fluttertoast.showToast(msg: 'Error updating profile: $error');
      isLoading(false);
    }
  }

  Future<void> onTapUpdateAddress() async {
    try {
      isLoading(true);
      UserModel updatedUserData = getUserDataFromEditedValues();
      await UserDataService().updateUserData(updatedUserData);
      isLoading(false);
      updateAddAddressIndex();
      Fluttertoast.showToast(msg: 'Profile Updated');
    } catch (error) {
      Fluttertoast.showToast(msg: 'Error updating profile: $error');
      isLoading(false);
    }
  }

  UserModel getUserDataFromEditedValues() {
    return UserModel(
      email: UserDataService().userModel!.email,
    );
  }
}
