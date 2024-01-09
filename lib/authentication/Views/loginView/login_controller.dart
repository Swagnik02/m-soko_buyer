import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:m_soko/authentication/auth_exceptions.dart';
import 'package:m_soko/common/utils.dart';
import 'package:m_soko/models/user_model.dart';
import 'package:m_soko/routes/app_routes.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';

class LoginController extends GetxController {
  late final TextEditingController email;
  late final TextEditingController password;
  bool isPasswordVisible = false;
  final currentUser = FirebaseAuth.instance.currentUser;
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
    email = TextEditingController(text: GlobalUtil.testUserEmail);
    password = TextEditingController(text: GlobalUtil.testUserPassword);
    super.onInit();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  void intializeCalling({
    required String userId,
    required String userName,
  }) {
    /// 1.2.1. initialized ZegoUIKitPrebuiltCallInvitationService
    /// when app's user is logged in or re-logged in
    /// We recommend calling this method as soon as the user logs in to your app.
    try {
      ZegoUIKitPrebuiltCallInvitationService().init(
        appID: GlobalUtil.appIdForCalling /*input your AppID*/,
        appSign: GlobalUtil.appSignForCalling /*input your AppSign*/,
        userID: userId,
        userName: userName,
        plugins: [
          ZegoUIKitSignalingPlugin(),
        ],
      );
    } catch (e) {
      Logger().e(e.toString());
    }
  }

  // Future<void> logIn() async {
  //   try {
  //     await FirebaseAuth.instance
  //         .signInWithEmailAndPassword(
  //           email: email.text,
  //           password: password.text,
  //         )
  //         .then((value) => Get.offAllNamed(AppRoutes.homeScreen));
  //   } on FirebaseAuthException catch (e) {
  //     Logger().e(e);
  //   }
  // }
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
          intializeCalling(
              userId: email.text.toString(),
              userName: value.user!.displayName.toString());
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
