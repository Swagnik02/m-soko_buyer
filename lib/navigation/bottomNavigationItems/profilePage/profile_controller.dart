import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_soko/common/utils.dart';
import 'package:m_soko/models/user_model.dart';

class ProfileController extends GetxController {
  var n = 4;
  var index = 0;

  late TextEditingController userNameController;
  late TextEditingController mobileController;
  late TextEditingController cityController;
  late TextEditingController stateController;
  late TextEditingController countryController;
  late TextEditingController pincodeController;

  @override
  void onInit() {
    super.onInit();

    userNameController = TextEditingController(text: Users.userName);
    mobileController = TextEditingController(text: Users.mobile);
    cityController = TextEditingController(text: Users.city);
    stateController = TextEditingController(text: Users.state);
    countryController = TextEditingController(text: Users.country);
    pincodeController = TextEditingController(text: Users.pin);
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
      email: Users.email,
    );
  }
}
