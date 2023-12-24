// ignore_for_file: unnecessary_null_comparison

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class RegisterController extends GetxController {
  late final TextEditingController name;
  late final TextEditingController email;
  late final TextEditingController password;
  late final TextEditingController confirmPassword;
  bool isPasswordVisible1 = false;
  bool isPasswordVisible2 = false;

  @override
  void onInit() {
    name = TextEditingController();
    email = TextEditingController();
    password = TextEditingController();
    confirmPassword = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    name.dispose();
    email.dispose();
    password.dispose();
    confirmPassword.dispose();
    super.dispose();
  }

  void togglePasswordFunc1() {
    isPasswordVisible1 = !isPasswordVisible1;
    update();
  }

  void togglePasswordFunc2() {
    isPasswordVisible2 = !isPasswordVisible2;
    update();
  }

  Future<void> createUser() async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: email.text,
        password: password.text,
      )
          .then((value) async {
        if (value != null) {
          await value.user!.updateDisplayName(name.text);
        }
      });
    } on FirebaseAuthException catch (e) {
      Logger().e(e);
      // if (e.code == 'weak-password') {
      //   throw WeakPasswordAuthException();
      // } else if (e.code == 'email-already-in-use') {
      //   throw EmailAlreadyInUseAuthException();
      // } else if (e.code == 'invalid-email') {
      //   throw InvalidEmailAuthException();
      // } else {
      //   throw GenericAuthException();
      // }
    }
  }
}
