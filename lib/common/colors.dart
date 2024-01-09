import 'package:flutter/material.dart';

class ColorConstants {
  static const Color bgColour = Color(0xF0E6E6E6);
  // Define blue shades
  static const Color blue50 = Color(0xFFE7EAF3);
  static const Color blue100 = Color(0xFFB3BFD9);
  static const Color blue200 = Color(0xFF819FC6);
  static const Color blue300 = Color(0xFF5C74AD);
  static const Color blue400 = Color(0xFF3C599D);
  static const Color blue500 = Color(0xFF062184);
  static const Color blue600 = Color(0xFF002B78);
  static const Color blue700 = Color(0xFF08215E);
  static const Color blue800 = Color(0xFF061A49);
  static const Color blue900 = Color(0xFF051437);
  static const Color skyBlue = Color(0xFF3072D4);

  // Define yellow shades
  static const Color yellow50 = Color(0xFFFBF8E7);
  static const Color yellow100 = Color(0xFFF4E9B3);
  static const Color yellow200 = Color(0xFFEEDF8F);
  static const Color yellow300 = Color(0xFFE6CF5C);
  static const Color yellow400 = Color(0xFFE1C63C);
  static const Color yellow500 = Color(0xFFDAB80B);
  static const Color yellow600 = Color(0xFFC6A70A);
  static const Color yellow700 = Color(0xFF9B8308);
  static const Color yellow800 = Color(0xFF786506);
  static const Color yellow900 = Color(0xFF5C4D05);

  // Define green shades
  static const Color green50 = Color(0xFFECFDE7);
  static const Color green100 = Color(0xFFC4F8B5);
  static const Color green200 = Color(0xFFA7F492);
  static const Color green300 = Color(0xFF7FF060);
  static const Color green400 = Color(0xFF66ED41);
  static const Color green500 = Color(0xFF40E811);
  static const Color green600 = Color(0xFF3AD30F);
  static const Color green700 = Color(0xFF2DA50C);
  static const Color green800 = Color(0xFF238009);
  static const Color green900 = Color(0xFF1B6107);

  // Define orange shades
  static const Color orange50 = Color(0xFFFEF2E6);
  static const Color orange100 = Color(0xFFFAD8B0);
  static const Color orange200 = Color(0xFFF8C58A);
  static const Color orange300 = Color(0xFFF5AA54);
  static const Color orange400 = Color(0xFFF39933);
  static const Color orange500 = Color(0xFFF08000);
  static const Color orange600 = Color(0xFFDA7400);
  static const Color orange700 = Color(0xFFA05000);
  static const Color orange800 = Color(0xFF844600);
  static const Color orange900 = Color(0xFF653600);

  // ChatUI
  static const Color white18 = Color(0x2EFFFFFF);
  static const Color black18 = Color(0x2E000000);

  static const Color white8 = Color(0x14FFFFFF);
  static const Color black8 = Color(0x14000000);

  static const Color white72 = Color(0xB8FFFFFF);
  static const Color black72 = Color(0xB8000000);

  static Color chatsSeparatorLineColor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? white18 : black18;

  static Color chatsAttachmentIconColor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? white72 : black72;

  static Color chatMessageInputBGColor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? white8 : black8;

  static Color chatMessageOverlayBGColor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? white8 : black8;
}
