import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class GlobalUtil {
  static const String currencySymbol = '₹';
  static int? isViewed;
  static const String ONBOARDINGTOKEN = '';
  static const String demoText =
      'Lorem ipsum dolor sit amet consectetur adipisicing elit.';
}

class Utils {
  static Widget customLoadingSpinner(){
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  static int calculateColumnCount(double screenWidth) {
    double widthThreshold = 600; // Adjust this value as needed

    int columnCount = (screenWidth / widthThreshold).floor();
    return columnCount > 0 ? columnCount : 1;
  }

  static String formatPostDate(String postDate) {
    String formattedDate = '';

    try {
      DateTime parsedDate = DateTime.parse(postDate);
      formattedDate = DateFormat('MMM dd').format(parsedDate); // Format as 'Dec 27'
    } catch (e) {
      // log('Error parsing or formatting date: $e');
      formattedDate = 'Invalid Date';
    }

    return formattedDate;
  }
}