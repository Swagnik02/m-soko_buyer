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
      'itemImage': doc['itemImage'],
      'itemName': doc['itemName'],
      'itemSubCategory': doc['itemSubCategory'],
      'itemPrice': doc['itemPrice'],
      'itemShippingCharge': doc['itemShippingCharge'],
      'itemDiscountPercentage': doc['itemDiscountPercentage'],
      'itemOrderCount': doc['itemOrderCount'],

      // indetails
      'itemImage1': doc['itemImage1'],
      'itemImage2': doc['itemImage2'],
      'itemImage3': doc['itemImage3'],

      // specs/Highlights

      // ratings and reviews
      // Add the remaining fields here
    };
  }).toList();
}



// Future<void> fetchProductDetails() async {
//     try {
//       var docSnapshot = await FirebaseFirestore.instance
//           .collection('product_Items')
//           .doc(uid)  // Replace 'pid' with 'uid' if the field name is 'uid'
//           .get();

//       if (docSnapshot.exists) {
//         var doc = docSnapshot.data() as Map<String, dynamic>;
//         ProductModel productDetails = ProductModel(
//           prdItemCategory: doc['prdItemCategory'],
//           pid: doc['pid'],
//           UID: doc['UID'],
//           itemImage: doc['itemImage'],
//           itemName: doc['itemName'],
//           itemSubCategory: doc['itemSubCategory'],
//           itemPrice: doc['itemPrice'].toDouble(),
//           itemShippingCharge: doc['itemShippingCharge'].toDouble(),
//           itemDiscountPercentage: doc['itemDiscountPercentage'].toDouble(),
//           itemOrderCount: doc['itemOrderCount'],
//           itemImage1: doc['itemImage1'],
//           itemImage2: doc['itemImage2'],
//           itemImage3: doc['itemImage3'],
//           // Add more fields as needed
//         );

//         // Now, navigate to the ProductItemDetailPage with the fetched details
//         Navigator.of(context).push(PageRouteBuilder(
//           pageBuilder: (context, animation, secondaryAnimation) {
//             return ProductItemDetailPage(
//               productModel: productDetails,
//               title: productDetails.itemName,
//               discountInPercentage: productDetails.itemDiscountPercentage,
//             );
//           },
//           transitionsBuilder: customTransition(const Offset(0, 0)),
//         ));
//       } else {
//         print('Product with UID $uid not found');
//         // Handle the case where the product is not found
//       }
//     } catch (error) {
//       print('Error fetching product details: $error');
//       // Handle the error
//     }
//   }