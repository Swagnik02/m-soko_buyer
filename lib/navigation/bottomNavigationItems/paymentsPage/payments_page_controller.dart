import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PaymentsPageController extends GetxController {
  var mobileNumberController = TextEditingController();
  var countryCodeController = TextEditingController();
  var productNameController = TextEditingController();
  var amountController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    countryCodeController = TextEditingController(text: '+91');
  }

  void payNow() async {
    Fluttertoast.showToast(msg: 'Pay now');
  }

  Future<bool> onWillPop() async {
    Get.back();
    Get.delete<PaymentsPageController>();
    return true;
  }
}
