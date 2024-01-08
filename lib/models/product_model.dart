import 'dart:developer' as devtools show log;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:m_soko/common/utils.dart';

class ProductModel {
  String? itemName;
  String? itemSubCategory;
  double? itemMrp;
  String? mainCategory;
  String? productId;
  String? itemThumbnail;
  double? itemShippingCharge;
  double? itemDiscountPercentage;
  int? itemOrderCount;
  Map<String, String>? itemImages;

  // ratings and reviews
  String? itemRatingGrade;
  double? itemAvgRating;
  double? itemTotalRatingCount;
  double? itemTotalReviewCount;

  // mobile specs
  String? ram;
  String? rom;
  String? processor;
  String? rearCamera;
  String? frontCamera;
  String? display;
  String? battery;
  String? networkType;
  String? simType;
  String? isExpandableStorage;
  String? isAudioJack;
  String? isQuickCharging;
  String? inTheBox;

  // seller info
  String? sellerUid;
  String? sellerEmail;
  String? sellerUserName;

  // Constructor
  ProductModel({
    this.itemName,
    this.itemSubCategory,
    this.itemMrp,
    this.mainCategory,
    this.productId,
    this.itemThumbnail,
    this.itemShippingCharge,
    this.itemDiscountPercentage,
    this.itemOrderCount,
    this.itemImages,

    // ratings and reviews
    this.itemRatingGrade = '',
    this.itemAvgRating,
    this.itemTotalRatingCount = 2000,
    this.itemTotalReviewCount = 200,

    // mobile specs
    this.ram,
    this.rom,
    this.processor,
    this.rearCamera,
    this.frontCamera,
    this.display,
    this.battery,
    this.networkType,
    this.simType,
    this.isExpandableStorage,
    this.isAudioJack,
    this.isQuickCharging,
    this.inTheBox,

    // seller info
    this.sellerUid,
    this.sellerEmail,
    this.sellerUserName,
  });

  // Factory method to create a ProductModel from a Map
  factory ProductModel.fromMap(Map<String, dynamic> data) {
    double? itemAvgRating = (data['itemAvgRating'] as num?)?.toDouble();

    String itemRatingGrade = determineRatingGrade(itemAvgRating);

    return ProductModel(
      itemName: data['itemName'],
      itemSubCategory: data['itemSubCategory'],
      itemMrp: (data['itemMrp'] as num?)?.toDouble(),
      mainCategory: data['prdItemCategory'],
      productId: data['pid'],
      itemThumbnail: data['itemThumbnail'],
      itemShippingCharge: (data['itemShippingCharge'] as num?)?.toDouble(),
      itemDiscountPercentage:
          (data['itemDiscountPercentage'] as num?)?.toDouble(),
      itemOrderCount: data['itemOrderCount'],
      itemImages: (data['itemImages'] as Map<String, dynamic>?)
          ?.map((key, value) => MapEntry(key, value as String)),

      // ratings and reviews
      itemAvgRating: itemAvgRating,
      itemRatingGrade: itemRatingGrade,

      // mobile specs
      ram: data['ram'],
      rom: data['rom'],
      processor: data['processor'],
      rearCamera: data['rearCamera'],
      frontCamera: data['frontCamera'],
      display: data['display'],
      battery: data['battery'],
      networkType: data['networkType'],
      simType: data['simType'],
      isExpandableStorage: data['isExpandableStorage'] == 1 ? 'YES' : 'NO',
      isAudioJack: data['isAudioJack'] == 1 ? 'YES' : 'NO',
      isQuickCharging: data['isQuickCharging'] == 1 ? 'YES' : 'NO',
      inTheBox: data['inTheBox'],

      // seller info
      sellerEmail: data['sellerEmail'],

      sellerUid: data['sellerUid'],
      sellerUserName: data['sellerUsername'],
    );
  }
  static String determineRatingGrade(double? itemAvgRating) {
    if (itemAvgRating == null) {
      return 'No Ratings Yet';
    } else if (itemAvgRating >= 4.5) {
      return 'Recommended';
    } else if (itemAvgRating >= 3.5) {
      return 'Good';
    } else if (itemAvgRating >= 2.5) {
      return 'Average';
    } else {
      return 'Below Average';
    }
  }
}

Future<ProductModel?> collectProductData(String pid) async {
  try {
    CollectionReference productItemsCollection =
        FirebaseFirestore.instance.collection('product_items');
    QuerySnapshot querySnapshot =
        await productItemsCollection.where('pid', isEqualTo: pid).get();
    if (querySnapshot.docs.isNotEmpty) {
      DocumentSnapshot productDocument = querySnapshot.docs.first;
      Map<String, dynamic> productData =
          productDocument.data() as Map<String, dynamic>;

      devtools.log('Product Data for $pid: $productData');

      // seller data
      String? sellerEmail = productData['seller_email'];
      if (sellerEmail != null) {
        String sellerUid;
        String sellerUsername;
        var sellerSnapshot = await FirebaseFirestore.instance
            .collection(FirestoreCollections.usersCollection)
            .doc(sellerEmail)
            .get();

        if (sellerSnapshot.exists) {
          sellerUid = sellerSnapshot['uid'].toString();
          sellerUsername = sellerSnapshot['userName'].toString();
          productData['sellerEmail'] = sellerEmail;
          productData['sellerUid'] = sellerUid;
          productData['sellerUsername'] = sellerUsername;
        }
      }
      // seller data

      // Create a ProductModel from the retrieved data
      ProductModel productModel = ProductModel.fromMap(productData);
      return productModel;
    } else {
      devtools.log('No product found with pid: $pid');
      return null;
    }
  } catch (e) {
    devtools.log('Error collecting product data: $e');
    return null;
  }
}
