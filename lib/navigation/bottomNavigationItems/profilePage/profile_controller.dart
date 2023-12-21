import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  // Reactive state variables
  var n = 4.obs; // Example reactive variable
  var index = 0.obs; // Example reactive variable for index

  // Controllers for the TextFields in _editProfile
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _mobileController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _stateController = TextEditingController();
  TextEditingController _countryController = TextEditingController();
  TextEditingController _pincodeController = TextEditingController();

  // Add more state variables as needed

  @override
  void onInit() {
    super.onInit();
    // Initialize your state variables here

    // Example initialization for controllers
    _userNameController.text = "Initial Username";
    _mobileController.text = "Initial Mobile";
    _cityController.text = "Initial City";
    _stateController.text = "Initial State";
    _countryController.text = "Initial Country";
    _pincodeController.text = "Initial Pincode";
  }

  // Example method to update index
  void updateIndex(int newIndex) {
    index.value = newIndex;
  }

  // Add more methods to update state variables as needed
  void updateN(int newValue) {
    n.value = newValue;
  }

  // Example getters for controllers
  TextEditingController get userNameController => _userNameController;
  TextEditingController get mobileController => _mobileController;
  TextEditingController get cityController => _cityController;
  TextEditingController get stateController => _stateController;
  TextEditingController get countryController => _countryController;
  TextEditingController get pincodeController => _pincodeController;
}
