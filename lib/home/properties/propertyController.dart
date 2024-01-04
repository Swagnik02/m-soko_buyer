import 'dart:developer';

import 'package:carousel_slider/carousel_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:currency_converter/currency.dart';
import 'package:currency_converter/currency_converter.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class PropertyController extends GetxController {
  late TextEditingController searchController;
  final CarouselController carouselController = CarouselController();
  final CurrencyConverter converter = CurrencyConverter();
  int propertyImageCurrentIndex = 0;
  String selectedSortOption = '';

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

  void setSortValue(sortValue) {
    selectedSortOption = sortValue;
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

  // Existing code...

  Future<QuerySnapshot<Map<String, dynamic>>> fetchDataFromFirebase(
      {String? sortOption}) async {
    Query<Map<String, dynamic>> collection =
        FirebaseFirestore.instance.collection('property_items');

    if (sortOption == 'highToLow') {
      collection = collection.orderBy('Selling Price', descending: true);
    } else if (sortOption == 'lowToHigh') {
      collection = collection.orderBy('Selling Price');
    }

    var querySnapshot = await collection.get();
    return querySnapshot;
  }
}
