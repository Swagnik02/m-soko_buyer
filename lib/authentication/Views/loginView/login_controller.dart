import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:m_soko/authentication/auth_exceptions.dart';
import 'package:m_soko/models/user_model.dart';
import 'package:m_soko/routes/app_routes.dart';

class LoginController extends GetxController {
  late final TextEditingController email;
  late final TextEditingController password;
  bool isPasswordVisible = false;
  bool isLoading = false;

  void togglePasswordVisibleFunc() {
    isPasswordVisible = !isPasswordVisible;
    update();
  }

  void toggleLoading() {
    isLoading = !isLoading;
    update();
  }

  @override
  void onInit() {
    email = TextEditingController(text: 'abc@gmail.com');
    password = TextEditingController(text: 'password02');
    super.onInit();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  Future<void> logIn() async {
    try {
      toggleLoading();
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: email.text,
        password: password.text,
      )
          .then((value) {
        UserDataService().fetchUserData(email.text).then((_) {
          // // Store user data locally after successful login
          UserDataService().storeUserDataLocally();
        });
        toggleLoading();

        // Navigate to the home screen
        Get.offAllNamed(AppRoutes.homeScreen);
      });
    } on FirebaseAuthException catch (e) {
      Logger().e(e);
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        toggleLoading();
        throw InvalidCredentialsException();
      } else if (e.code == 'network-request-failed') {
        toggleLoading();
        throw NetworkErrorException();
      } else {
        toggleLoading();
        // Handle other FirebaseAuth exceptions here
      }
    }
  }
}
