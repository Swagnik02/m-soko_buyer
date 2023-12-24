import 'dart:developer';

import 'package:carousel_slider/carousel_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class PropertyController extends GetxController {
  late TextEditingController searchController;
  final CarouselController carouselController = CarouselController();
  int propertyImageCurrentIndex = 0;

  // List homeImages = [];

  var isExpandedForDisclaimer = true.obs;
  var isExpandedForPropertyDescription = true.obs;

  void toggleExpandedForDisclaimer() {
    isExpandedForDisclaimer.toggle();
  }

  void toggleExpandedForPropertyDescription() {
    isExpandedForPropertyDescription.toggle();
  }

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

  void setImageViewIndex(int i) {
    propertyImageCurrentIndex = i;
    update();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>>
      fetchHomeImageFromFirebase() async {
    var querySnapshot = await FirebaseFirestore.instance
        .collection('property_basic_images')
        .doc('HomeImage')
        .get();
    return querySnapshot;
  }

  Future<QuerySnapshot<Map<String, dynamic>>> fetchDataFromFirebase() async {
    var querySnapshot =
        await FirebaseFirestore.instance.collection('property_items').get();

    return querySnapshot;
  }
}
