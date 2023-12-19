import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:m_soko/routes/app_routes.dart';

class LoginController extends GetxController {
  late final TextEditingController email;
  late final TextEditingController password;
  bool isPasswordVisible = false;

  void togglePasswordVisibleFunc() {
    isPasswordVisible = !isPasswordVisible;
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
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
            email: email.text,
            password: password.text,
          )
          .then((value) => Get.offAllNamed(AppRoutes.homeScreen));
    } on FirebaseAuthException catch (e) {
      Logger().e(e);
    }
  }
}
