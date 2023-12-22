import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_soko/models/user_model.dart';

class ProfileController extends GetxController {
  var n = 4;
  var index = 0;
  var isLoading = false.obs;

  late TextEditingController userNameController;
  late TextEditingController mobileController;
  late TextEditingController cityController;
  late TextEditingController stateController;
  late TextEditingController countryController;
  late TextEditingController pincodeController;

  @override
  void onInit() {
    super.onInit();

    userNameController =
        TextEditingController(text: UserDataService().userModel!.userName);
    mobileController =
        TextEditingController(text: UserDataService().userModel!.mobile);
    cityController =
        TextEditingController(text: UserDataService().userModel!.city);
    stateController =
        TextEditingController(text: UserDataService().userModel!.state);
    countryController =
        TextEditingController(text: UserDataService().userModel!.country);
    pincodeController =
        TextEditingController(text: UserDataService().userModel!.pin);
  }

  @override
  void dispose() {
    super.dispose();

    userNameController.dispose();
    mobileController.dispose();
    cityController.dispose();
    stateController.dispose();
    countryController.dispose();
    pincodeController.dispose();
  }

  void updateIndex(int newIndex) {
    index = newIndex;
    update();
  }

  UserModel getUserDataFromEditedValues() {
    String updatedUserName = userNameController.text;
    String updatedCountry = countryController.text;
    String updatedPin = pincodeController.text;
    String updatedCity = cityController.text;
    String updatedMobile = mobileController.text;
    String updatedState = stateController.text;

    return UserModel(
      userName: updatedUserName,
      country: updatedCountry,
      pin: updatedPin,
      city: updatedCity,
      mobile: updatedMobile,
      state: updatedState,
      email: UserDataService().userModel!.email,
    );
  }
}
