import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class PropertyController extends GetxController {
  late TextEditingController searchController;
  List homeImages = [];

  @override
  void onInit() {
    super.onInit();
    searchController = TextEditingController();
    fetchDataFromFirebase();
  }

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  Future<void> fetchDataFromFirebase() async {
    var querySnapshot = await FirebaseFirestore.instance
        .collection('property_items')
        .doc('basic_images')
        .get();

    if (querySnapshot.exists) {
      // Retrieving data from the document
      Map<String, dynamic>? data = querySnapshot.data();

      if (data != null) {
        // Extract only the values as List<dynamic>
        List values = data.values.toList();

        homeImages = values;
        log(homeImages.toString());
        update();
      } else {
        print('No data found in the Firestore document.');
      }
    } else {
      print('Firestore document does not exist or has no data.');
    }
  }
}
