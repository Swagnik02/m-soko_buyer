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
      'itemMrp': (doc['itemMrp'] as num).toDouble(),
      'itemShippingCharge': doc['itemShippingCharge'],
      'itemDiscountPercentage':
          (doc['itemDiscountPercentage'] as num).toDouble(),
      'itemOrderCount': doc['itemOrderCount'],
    };
  }).toList();
}

Future<List<Map<String, dynamic>>> futureSearchResultProducts(
    String keyword) async {
  var querySnapshot =
      await FirebaseFirestore.instance.collection('product_items').get();

  var filteredDocs = querySnapshot.docs
      .where((doc) =>
          doc['itemName'].toLowerCase().contains(keyword.toLowerCase()) ||
          doc['itemSubCategory']
              .toLowerCase()
              .contains(keyword.toLowerCase()) ||
          doc['prdItemCategory'].toLowerCase().contains(keyword.toLowerCase()))
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
      'itemMrp': (doc['itemMrp'] as num).toDouble(),
      'itemShippingCharge': doc['itemShippingCharge'],
      'itemDiscountPercentage':
          (doc['itemDiscountPercentage'] as num).toDouble(),
      'itemOrderCount': doc['itemOrderCount'],
    };
  }).toList();
}

Future<List<Map<String, dynamic>>> futureSearchFilterProducts(
  String keyword,
  String ratings,
  Set<String> ramSet,
  Set<String> romSet,
  Set<String> displaySet,
) async {
  var querySnapshot =
      await FirebaseFirestore.instance.collection('product_items').get();

  var filteredDocs = querySnapshot.docs.where((doc) {
    return (doc['itemName'].toLowerCase().contains(keyword.toLowerCase()) ||
            doc['itemSubCategory']
                .toLowerCase()
                .contains(keyword.toLowerCase()) ||
            doc['prdItemCategory']
                .toLowerCase()
                .contains(keyword.toLowerCase())) &&
        doc['ram']
            .toLowerCase()
            .contains(ramSet.first.toString().toLowerCase());
  }).toList();

  return filteredDocs.map((doc) {
    return {
      // main Category
      'prdItemCategory': doc['prdItemCategory'],
      'pid': doc['pid'],

      // basic infos for thumbnail
      'itemThumbnail': doc['itemThumbnail'],
      'itemName': doc['itemName'],
      'itemSubCategory': doc['itemSubCategory'],
      'itemMrp': (doc['itemMrp'] as num).toDouble(),
      'itemShippingCharge': doc['itemShippingCharge'],
      'itemDiscountPercentage':
          (doc['itemDiscountPercentage'] as num).toDouble(),
      'itemOrderCount': doc['itemOrderCount'],
    };
  }).toList();
}

Future<List<Map<String, dynamic>>> sortByPrice(
  String keyword,
  bool isDescending,
) async {
  var querySnapshot =
      await FirebaseFirestore.instance.collection('product_items').get();

  var filteredDocs = querySnapshot.docs
      .where((doc) =>
          doc['itemName'].toLowerCase().contains(keyword.toLowerCase()) ||
          doc['itemSubCategory']
              .toLowerCase()
              .contains(keyword.toLowerCase()) ||
          doc['prdItemCategory'].toLowerCase().contains(keyword.toLowerCase()))
      .toList();

  if (isDescending) {
    // Sorting by itemMrp in descending order (high to low)
    filteredDocs.sort(
        (a, b) => b['itemMrp'].toDouble().compareTo(a['itemMrp'].toDouble()));
  } else {
    // Sorting by itemMrp in ascending order (high to low)
    filteredDocs.sort(
        (a, b) => a['itemMrp'].toDouble().compareTo(b['itemMrp'].toDouble()));
  }

  return filteredDocs.map((doc) {
    return {
      // main Category
      'prdItemCategory': doc['prdItemCategory'],
      'pid': doc['pid'],

      // basic infos for thumbnail
      'itemThumbnail': doc['itemThumbnail'],
      'itemName': doc['itemName'],
      'itemSubCategory': doc['itemSubCategory'],
      'itemMrp': (doc['itemMrp'] as num).toDouble(),
      'itemShippingCharge': doc['itemShippingCharge'],
      'itemDiscountPercentage':
          (doc['itemDiscountPercentage'] as num).toDouble(),
      'itemOrderCount': doc['itemOrderCount'],
    };
  }).toList();
}
