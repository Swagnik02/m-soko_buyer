import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:m_soko/models/product_category_model.dart';

Future<List<Map<String, dynamic>>> fetchAdvertisementsFromFirestore() async {
  var querySnapshot =
      await FirebaseFirestore.instance.collection('advertisement').get();

  // Filter documents with 'adType' equal to 'product'
  var filteredDocs = querySnapshot.docs
      .where((doc) => doc['adType'] != null && doc['adType'] == 'product');

  return filteredDocs.map((doc) {
    return {
      'brandName': doc['brandName'],
      'bannerImage': doc['bannerImage'],
    };
  }).toList();
}

Future<List<Map<String, dynamic>>> fetchCategoriesFromFirestore() async {
  var querySnapshot =
      await FirebaseFirestore.instance.collection('product_categories').get();

  return querySnapshot.docs.map((doc) {
    return {
      'categoryName': doc['categoryName'],
      'categoryImage': doc['categoryImage'],
    };
  }).toList();
}

Future<List<ProductsCategoryModel>> futureCheckSelectedCategoryProducts(
    String category) async {
  var querySnapshot =
      await FirebaseFirestore.instance.collection('product_items').get();

  var filteredDocs =
      querySnapshot.docs.where((doc) => doc['prdItemCategory'] == category);

  return filteredDocs.map((doc) {
    return ProductsCategoryModel(
      prdItemCategory: doc['prdItemCategory'],
      pid: doc['pid'],
      itemThumbnail: doc['itemThumbnail'],
      itemName: doc['itemName'],
      itemSubCategory: doc['itemSubCategory'],
      itemMrp: (doc['itemMrp'] as num).toDouble() ?? 0.0,
      itemShippingCharge: (doc['itemShippingCharge'] as num).toDouble(),
      itemDiscountPercentage: (doc['itemDiscountPercentage'] as num).toDouble(),
      itemOrderCount: doc['itemOrderCount'],
    );
  }).toList();
}

Future<List<Map<String, dynamic>>> futureSearchResultProducts(
    String category) async {
  var querySnapshot =
      await FirebaseFirestore.instance.collection('product_items').get();

  var filteredDocs = querySnapshot.docs
      .where((doc) =>
          doc['itemName'].toLowerCase().contains(category.toLowerCase()) ||
          doc['itemSubCategory']
              .toLowerCase()
              .contains(category.toLowerCase()) ||
          doc['prdItemCategory'].toLowerCase().contains(category.toLowerCase()))
      .toList();

  return filteredDocs.map((doc) {
    return {
      // main Category
      'prdItemCategory': doc['prdItemCategory'],
      'pid': doc['pid'],

      // basic infos for thumbnail
      'itemThumbnail': doc['itemThumbnail'],
      'itemName': doc['itemName'],
      'itemSubCategory': doc['itemSubCategory'],
      'itemMrp': doc['itemMrp'],
      'itemShippingCharge': doc['itemShippingCharge'],
      'itemDiscountPercentage': doc['itemDiscountPercentage'],
      'itemOrderCount': doc['itemOrderCount'],
    };
  }).toList();
}

Future<List<Map<String, dynamic>>> sortByPriceHighToLow(String category) async {
  var querySnapshot =
      await FirebaseFirestore.instance.collection('product_items').get();

  var filteredDocs = querySnapshot.docs
      .where((doc) =>
          doc['itemName'].toLowerCase().contains(category.toLowerCase()) ||
          doc['itemSubCategory']
              .toLowerCase()
              .contains(category.toLowerCase()) ||
          doc['prdItemCategory'].toLowerCase().contains(category.toLowerCase()))
      .toList();

  // Sorting by itemMrp in descending order (high to low)
  filteredDocs.sort(
      (a, b) => b['itemMrp'].toDouble().compareTo(a['itemMrp'].toDouble()));

  return filteredDocs.map((doc) {
    return {
      // main Category
      'prdItemCategory': doc['prdItemCategory'],
      'pid': doc['pid'],

      // basic infos for thumbnail
      'itemThumbnail': doc['itemThumbnail'],
      'itemName': doc['itemName'],
      'itemSubCategory': doc['itemSubCategory'],
      'itemMrp': doc['itemMrp'],
      'itemShippingCharge': doc['itemShippingCharge'],
      'itemDiscountPercentage': doc['itemDiscountPercentage'],
      'itemOrderCount': doc['itemOrderCount'],
    };
  }).toList();
}

Future<List<Map<String, dynamic>>> sortByPriceLowToHigh(String category) async {
  var querySnapshot =
      await FirebaseFirestore.instance.collection('product_items').get();

  var filteredDocs = querySnapshot.docs
      .where((doc) =>
          doc['itemName'].toLowerCase().contains(category.toLowerCase()) ||
          doc['itemSubCategory']
              .toLowerCase()
              .contains(category.toLowerCase()) ||
          doc['prdItemCategory'].toLowerCase().contains(category.toLowerCase()))
      .toList();

  // Sorting by itemMrp in ascending order (low to high)
  filteredDocs.sort(
      (a, b) => a['itemMrp'].toDouble().compareTo(b['itemMrp'].toDouble()));

  return filteredDocs.map((doc) {
    return {
      // main Category
      'prdItemCategory': doc['prdItemCategory'],
      'pid': doc['pid'],

      // basic infos for thumbnail
      'itemThumbnail': doc['itemThumbnail'],
      'itemName': doc['itemName'],
      'itemSubCategory': doc['itemSubCategory'],
      'itemMrp': doc['itemMrp'],
      'itemShippingCharge': doc['itemShippingCharge'],
      'itemDiscountPercentage': doc['itemDiscountPercentage'],
      'itemOrderCount': doc['itemOrderCount'],
    };
  }).toList();
}
