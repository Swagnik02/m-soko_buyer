import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:m_soko/common/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GlobalUtil {
  // test user credentials
  static const String testUserEmail = 'testuser1@gmail.com';
  static const String testUserPassword = 'password02';

  static const String currencySymbol = '₹';
  static int? isViewed;
  static const String onBordingToken = '';
  static const String demoText =
      'Lorem ipsum dolor sit amet consectetur adipisicing elit.';
  static const int appIdForCalling = 268260452;
  static const String appSignForCalling =
      '7a4f548819ac66227eab9c1f882ded0a38b3b62dd3a52f8bba75c313a015a18b';
  static const String lorem =
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.';

  static const String visitUrl = 'https://help.sokoni.com';
  static const String contactEmail = 'customercare@sokoni.com';
  static const String contactMobile = '+91 6257899906';
}

class FirestoreCollections {
  static const String usersCollection = "users";
  static const String productsChatRoom = "productsChatRoom";
}

class Utils {
  static Widget customLoadingSpinner() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

// Function to generate a random dark color
  static Color generateRandomDarkColor() {
    Random random = Random();
    int red = random.nextInt(128); // Limiting red channel to darker shades
    int green = random.nextInt(128); // Limiting green channel to darker shades
    int blue = random.nextInt(128); // Limiting blue channel to darker shades
    return Color.fromARGB(255, red, green, blue);
  }

  // Function to save color to SharedPreferences
  static Future<void> saveColorToPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String colorHex =
        generateRandomDarkColor().value.toRadixString(16).padLeft(8, '0');
    await prefs.setString('storedColor', colorHex);
  }

  // Function to retrieve color from SharedPreferences
  static Future<Color?> getColorFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? colorHex = prefs.getString('storedColor');
    if (colorHex != null) {
      return Color(int.parse(colorHex, radix: 16));
    }
    return null;
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
    bool isSelected = false,
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
          border: Border.all(
              width: 2,
              color: isSelected ? ColorConstants.green700 : Colors.transparent),
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

Future<bool> showConfirmationDialog(BuildContext context) async {
  return await showDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Confirmation'),
            content:
                const Text('Are you sure you want to delete this address?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Delete'),
              ),
            ],
          );
        },
      ) ??
      false;
}
