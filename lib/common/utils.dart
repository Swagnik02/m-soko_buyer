import 'package:flutter/material.dart';

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
