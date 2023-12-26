import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:m_soko/common/colors.dart';

class GlobalUtil {
  static const String currencySymbol = '₹';
  static int? isViewed;
  static const String onBordingToken = '';
  static const String demoText =
      'Lorem ipsum dolor sit amet consectetur adipisicing elit.';
  static const int appIdForCalling = 268260452;
  static const String appSignForCalling =
      '7a4f548819ac66227eab9c1f882ded0a38b3b62dd3a52f8bba75c313a015a18b';
}

class Utils {
  static Widget customLoadingSpinner() {
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
      formattedDate =
          DateFormat('MMM dd').format(parsedDate); // Format as 'Dec 27'
    } catch (e) {
      // log('Error parsing or formatting date: $e');
      formattedDate = postDate;
    }

    return formattedDate;
  }

  static Widget customButton({
    required VoidCallback onTap,
    Color? backGroundColor,
    required String title,
    isIcon = true,
    Icon? icon,
    Size? size,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: size?.height,
        width: size?.width,
        // padding: EdgeInsets.symmetric(horizontal: Get.width * 0.02),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: backGroundColor ?? ColorConstants.blue700,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            isIcon
                ? icon ??
                    const Icon(
                      Icons.message,
                      color: Colors.white,
                    )
                : Container(),
            SizedBox(width: Get.width * 0.02),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }

  static Widget titleWithSubTitle({
    required String firstTitle,
    String? firstSubTitle,
    required String secondTitle,
    TextStyle? firstTextStyleTitle,
    TextStyle? secondTextStyleTitle,
    bool isSubTileSection = true,
    EdgeInsets? paddingSecond,
    String? secondSubTitle,
  }) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                firstTitle,
                style: firstTextStyleTitle ??
                    const TextStyle(
                        fontSize: 18,
                        color: Colors.grey,
                        fontWeight: FontWeight.w400),
              ),
              SizedBox(height: Get.height * 0.001),
              Text(
                firstSubTitle ?? '',
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
            ],
          ),
          isSubTileSection
              ? Padding(
                  padding: paddingSecond ?? EdgeInsets.zero,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        secondTitle,
                        style: secondTextStyleTitle ??
                            const TextStyle(
                                fontSize: 18,
                                color: Colors.grey,
                                fontWeight: FontWeight.w400),
                      ),
                      SizedBox(height: Get.height * 0.001),
                      Text(
                        secondSubTitle ?? '',
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                )
              : Container(),
        ],
      ),
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
