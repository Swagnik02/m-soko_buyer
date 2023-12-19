import 'dart:developer' as devtools show log;
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  String? name;
  String? subCategory;
  double? price;
  String? specs;

  // Constructor
  ProductModel({
    this.name,
    this.subCategory,
    this.price,
    this.specs,
  });

  // Factory method to create a ProductModel from a Map
  factory ProductModel.fromMap(Map<String, dynamic> data) {
    return ProductModel(
      name: data['itemName'],
      subCategory: data['itemSubCategory'],
      price: (data['itemPrice'] as num?)?.toDouble(),
      specs: data['itemspecs'],
      // Add other fields as needed
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
