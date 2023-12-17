import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class PropertyController extends GetxController {
  late TextEditingController searchController;
  // List homeImages = [];

  @override
  void onInit() {
    super.onInit();
    searchController = TextEditingController();
    // fetchHomeImageFromFirebase();
  }

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> fetchHomeImageFromFirebase() async {
    var querySnapshot = await FirebaseFirestore.instance
        .collection('property_items')
        .doc('basic_images')
        .get();
    return querySnapshot;
  }


  Future<QuerySnapshot<Map<String, dynamic>>> fetchDataFromFirebase() async {
    var querySnapshot = await FirebaseFirestore.instance
        .collection('property_items')
        .get();

    return querySnapshot;
  }

}
