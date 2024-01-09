import 'package:carousel_slider/carousel_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:currency_converter/currency_converter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

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
      collection = collection.orderBy('Selling Price (TZS)', descending: true);
    } else if (sortOption == 'lowToHigh') {
      collection = collection.orderBy('Selling Price (TZS)');
    }

    var querySnapshot = await collection.get();
    return querySnapshot;
  }

  Future<List<Map<String, dynamic>>> fetchData() async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection('Buyers')
          .doc(FirebaseAuth.instance.currentUser?.email.toString() ?? '')
          .collection('Call History')
          .get();

      List<Map<String, dynamic>> dataList = [];

      if (snapshot.size > 0) {
        snapshot.docs.forEach((doc) {
          // Extract data from each document
          Map<String, dynamic> data = doc.data();
          dataList.add(data);
          update();
        });
      }

      return dataList;
    } catch (e) {
      Logger().e(e.toString());
      return []; // Return an empty list in case of an error
    }
  }

  Future uploadCallingDataToFirebase(
      {required String agentName,
      required String agentEmail,
      required userType}) async {
    DateTime nowTime = DateTime.now();
    try {
      await FirebaseFirestore.instance
          .collection('Buyers')
          .doc(FirebaseAuth.instance.currentUser?.email.toString() ?? '')
          .collection('Call History')
          .doc()
          .set({
        'Name': agentName,
        'CallID': agentEmail,
        'Direction': "Outgoing",
        'Date-Time': nowTime,
        'User Type': 'Agents',
      });
      final userType = await fetchData();
      await FirebaseFirestore.instance
          .collection(
              (userType[0]['User Type'] == "Seller") ? "users" : "Agents")
          .doc(agentEmail)
          .collection('Call History')
          .doc()
          .set({
        'Name': FirebaseAuth.instance.currentUser?.displayName.toString() ?? '',
        'CallID': FirebaseAuth.instance.currentUser?.email.toString() ?? '',
        'Direction': "Incoming",
        'Date-Time': nowTime,
        'User Type': "Buyers"
      });
    } on FirebaseFirestore catch (e) {
      Logger().e(e.toString());
    }
  }
}
