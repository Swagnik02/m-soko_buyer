import 'dart:developer' as devtools show log;
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  String? name;
  String? subCategory;
  double? price;
  String? specs;
  String? mainCategory;
  String? productId;
  String? itemImage;
  double? itemShippingCharge;
  double? itemDiscountPercentage;
  int? itemOrderCount;
  String? itemImage1;
  String? itemImage2;
  String? itemImage3;

  // Constructor
  ProductModel({
    this.name,
    this.subCategory,
    this.price,
    this.specs,
    this.mainCategory,
    this.productId,
    this.itemImage,
    this.itemShippingCharge,
    this.itemDiscountPercentage,
    this.itemOrderCount,
    this.itemImage1,
    this.itemImage2,
    this.itemImage3,
  });

  // Factory method to create a ProductModel from a Map
  factory ProductModel.fromMap(Map<String, dynamic> data) {
    return ProductModel(
      name: data['itemName'],
      subCategory: data['itemSubCategory'],
      price: (data['itemPrice'] as num?)?.toDouble(),
      specs: data['itemspecs'],
      mainCategory: data['prdItemCategory'],
      productId: data['pid'],
      itemImage: data['itemImage'],
      itemShippingCharge: (data['itemShippingCharge'] as num?)?.toDouble(),
      itemDiscountPercentage:
          (data['itemDiscountPercentage'] as num?)?.toDouble(),
      itemOrderCount: data['itemOrderCount'],
      itemImage1: data['itemImage1'],
      itemImage2: data['itemImage2'],
      itemImage3: data['itemImage3'],
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
