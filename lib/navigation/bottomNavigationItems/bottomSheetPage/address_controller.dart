import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
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

  Future<void> onTapAddNewAddress() async {
    try {
      updateisLoadingIndex();
      await Future.delayed(Duration(seconds: 2));

      // // UserModel updatedUserData = getUserDataFromEditedValues();
      // // await UserDataService().updateUserData(updatedUserData);
      updateisLoadingIndex();
      updateAddAddressIndex();

      // Fluttertoast.showToast(msg: 'Address added');
    } catch (error) {
      Fluttertoast.showToast(msg: 'Error updating profile: $error');
      updateisLoadingIndex();
    }
  }

  // Future<void> onTapUpdateAddress() async {
  //   try {
  //     isLoading(true);
  //     UserModel updatedUserData = getUserDataFromEditedValues();
  //     await UserDataService().updateUserData(updatedUserData);
  //     isLoading(false);
  //     updateAddAddressIndex();
  //     Fluttertoast.showToast(msg: 'Profile Updated');
  //   } catch (error) {
  //     Fluttertoast.showToast(msg: 'Error updating profile: $error');
  //     isLoading(false);
  //   }
  // }

  UserModel getUserDataFromEditedValues() {
    return UserModel(
      email: UserDataService().userModel!.email,
    );
  }
}
