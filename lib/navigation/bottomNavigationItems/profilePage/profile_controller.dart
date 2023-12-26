import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:m_soko/models/user_model.dart';
import 'package:m_soko/routes/app_routes.dart';

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
        TextEditingController(text: UserDataService().userModel?.userName);
    mobileController =
        TextEditingController(text: UserDataService().userModel?.mobile);
    cityController =
        TextEditingController(text: UserDataService().userModel?.city);
    stateController =
        TextEditingController(text: UserDataService().userModel?.state);
    countryController =
        TextEditingController(text: UserDataService().userModel?.country);
    pincodeController =
        TextEditingController(text: UserDataService().userModel?.pin);
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

  Future<void> onTapUpdateProfile() async {
    try {
      isLoading(true);
      UserModel updatedUserData = getUserDataFromEditedValues();
      await UserDataService().updateUserData(updatedUserData);
      isLoading(false);
      updateIndex(0);
      Fluttertoast.showToast(msg: 'Profile Updated');
    } catch (error) {
      Fluttertoast.showToast(msg: 'Error updating profile: $error');
      isLoading(false);
    }
  }

  void onTapMyReview() {
    Fluttertoast.showToast(msg: 'My Review');
  }

  void onTapAddAccounts() {
    Fluttertoast.showToast(msg: 'Add Accounts');
  }

  void onTapLogOut() {
    FirebaseAuth.instance
        .signOut()
        .then((value) => Get.offAllNamed(AppRoutes.loginScreen));
    Fluttertoast.showToast(msg: 'Logged Out');
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
