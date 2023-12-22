import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:m_soko/models/user_model.dart';

class GlobalUtil {
  static const String currencySymbol = '₹';
  static int? isViewed;
  static const String onBordingToken = '';
  static const String demoText =
      'Lorem ipsum dolor sit amet consectetur adipisicing elit.';
}

class Utils {
  static Widget customLoadingSpinner() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

// class Users {
//   static final String? userId = UserDataService().userModel?.uid;
//   static final String? userName = UserDataService().userModel?.userName;
//   static final String email = UserDataService().userModel?.email ??
//       FirebaseAuth.instance.currentUser?.email ??
//       'user@email.com';
//   static final String? mobile = UserDataService().userModel?.mobile;
//   static final String? city = UserDataService().userModel?.city;
//   static final String? pin = UserDataService().userModel?.pin;
//   static final String? state = UserDataService().userModel?.state;
//   static final String? country = UserDataService().userModel?.country;
// }
