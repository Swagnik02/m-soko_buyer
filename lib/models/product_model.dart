import 'dart:developer' as devtools show log;
import 'package:cloud_firestore/cloud_firestore.dart';

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
  double? itemAvgRating;

  // mobile specs
  int? ram;
  int? rom;
  String? processor;
  String? rearCamera;
  String? frontCamera;
  String? display;
  String? battery;

  Map<String, String>? itemImages;

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
    this.itemAvgRating,
  });

  // Factory method to create a ProductModel from a Map
  factory ProductModel.fromMap(Map<String, dynamic> data) {
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
    );
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
