import 'package:cloud_firestore/cloud_firestore.dart';

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

Future<List<Map<String, dynamic>>> futureCheckSelectedCategoryProducts(
    String category) async {
  var querySnapshot =
      await FirebaseFirestore.instance.collection('product_items').get();

  var filteredDocs =
      querySnapshot.docs.where((doc) => doc['prdItemCategory'] == category);

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
