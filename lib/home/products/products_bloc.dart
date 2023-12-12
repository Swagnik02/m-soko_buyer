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
      await FirebaseFirestore.instance.collection('products').get();

  var filteredDocs =
      querySnapshot.docs.where((doc) => doc['prdItemCategory'] == category);

  return filteredDocs.map((doc) {
    return {
      'prdItemDesc': doc['prdItemDesc'],
      'prdItemImage1': doc['prdItemImage1'],
      'prdItemImage2': doc['prdItemImage2'],
      'prdItemImage3': doc['prdItemImage3'],
      'prdItemName': doc['prdItemName'],
      'prdItemPrice': doc['prdItemPrice'],
    };
  }).toList();
}
