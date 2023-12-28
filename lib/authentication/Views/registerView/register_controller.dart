import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:m_soko/authentication/auth_exceptions.dart';
import 'package:m_soko/routes/app_routes.dart';

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
    if (name.text.isEmpty ||
        email.text.isEmpty ||
        password.text.isEmpty ||
        confirmPassword.text.isEmpty) {
      throw EmptyFieldException('All fields');
    }
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: email.text,
        password: password.text,
      )
          .then((value) async {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(value.user!.email)
            .set({
          'uid': value.user!.uid,
          'userName': name.text,
          'email': value.user!.email,
        });

        FirebaseAuth.instance
            .signOut()
            .then((value) => Get.offAllNamed(AppRoutes.loginScreen));
        Fluttertoast.showToast(
            msg: 'Account Created', toastLength: Toast.LENGTH_SHORT);
      });
    } on FirebaseAuthException catch (e) {
      Logger().e(e);
      if (e.code == 'weak-password') {
        throw WeakPasswordException();
      } else if (e.code == 'email-already-in-use') {
        throw EmailAlreadyInUseException();
      } else if (e.code == 'invalid-email') {
        throw InvalidEmailException();
      } else {
        throw AuthException();
      }
    }
  }
}
