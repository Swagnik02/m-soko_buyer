import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

String lorem =
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.';

class LogoutScreen extends StatelessWidget {
  const LogoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Logout'),
      ),
      body: StreamBuilder(
        stream:
            FirebaseFirestore.instance.collection('product_items').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }

          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          // var documents = snapshot.data?.docs;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image(
              //   image: NetworkImage(
              // 'https://firebasestorage.googleapis.com/v0/b/msoko-
              // seller.appspot.com/o/ad_banners%2Fprd_ad_1.png?
              // alt=media&token=0dda43dd-29ed-4f71-a4c2-88804f5c463f'),
              // ),
              ElevatedButton(
                onPressed: () {
                  // Call a function to add categories
                  // addCategories();
                  addProducts();
                  // addProductsItems();
                },
                child: const Text('Add Categories'),
              ),
              TextButton(
                onPressed: () {
                  // context.read<AuthBloc>().add(
                  //       const AuthEventLogOut(),
                  //     );
                },
                child: const Text('Logout'),
              ),
              // for (var document in documents!)
              //   CategoryWidget(data: document.data() as Map<String, dynamic>),
              // for (var document in documents!)
              //   ShowProducts(data: document.data() as Map<String, dynamic>),
            ],
          );
        },
      ),
    );
  }
}

Future<void> addCategories() async {
  CollectionReference categories =
      FirebaseFirestore.instance.collection('advertisement');

  await categories.doc('prop_ad_0').set({
    'brandName': 'House',
    'bannerImage':
        'https://firebasestorage.googleapis.com/v0/b/msoko-seller.appspot.com/o/ad_banners%2Fprop_ad_1.png?alt=media&token=c39ab5c0-26a9-4ffa-96c9-447f188c39c6',
  });
  // await categories.doc('prd_ad_02').set({
  //   'brandName': 'Maha Electronics',
  //   'bannerImage':
  //       'https://firebasestorage.googleapis.com/v0/b/msoko-seller.appspot.com/o/ad_banners%2Fprd_ad_1.png?alt=media&token=0dda43dd-29ed-4f71-a4c2-88804f5c463f',
  // });
  // await categories.doc('prd_ad_03').set({
  //   'brandName': 'Maha Electronics',
  //   'bannerImage':
  //       'https://firebasestorage.googleapis.com/v0/b/msoko-seller.appspot.com/o/ad_banners%2Fprd_ad_1.png?alt=media&token=0dda43dd-29ed-4f71-a4c2-88804f5c463f',
  // });

//   // Reference to the Firestore collection
//   CollectionReference categories =
//       FirebaseFirestore.instance.collection('product_categories');

// // Assuming 'categories' is a reference to your Firebase Firestore collection

// // Add category 1: Electronics
//   await categories.doc('prd_cat_01').set({
//     'categoryName': 'Electronics',
//     'categoryImage': 'url_to_image_for_electronics',
//   });

// // Add category 2: Mobiles
//   await categories.doc('prd_cat_02').set({
//     'categoryName': 'Mobiles',
//     'categoryImage': 'url_to_image_for_mobiles',
//   });

// // Add category 3: Fashion
//   await categories.doc('prd_cat_03').set({
//     'categoryName': 'Fashion',
//     'categoryImage': 'url_to_image_for_fashion',
//   });

// // Add category 4: Personal Care
//   await categories.doc('prd_cat_04').set({
//     'categoryName': 'Personal Care',
//     'categoryImage': 'url_to_image_for_personal_care',
//   });

// // Add category 5: Footwear
//   await categories.doc('prd_cat_05').set({
//     'categoryName': 'Footwear',
//     'categoryImage': 'url_to_image_for_footwear',
//   });

// // Add category 6: Baby Products
//   await categories.doc('prd_cat_06').set({
//     'categoryName': 'Baby Products',
//     'categoryImage': 'url_to_image_for_baby_products',
//   });

// // Add category 7: Home
//   await categories.doc('prd_cat_07').set({
//     'categoryName': 'Home',
//     'categoryImage': 'url_to_image_for_home',
//   });

// // Add category 8: Eyewear
//   await categories.doc('prd_cat_08').set({
//     'categoryName': 'Eyewear',
//     'categoryImage': 'url_to_image_for_eyewear',
//   });

// // Add category 9: Furniture
//   await categories.doc('prd_cat_09').set({
//     'categoryName': 'Furniture',
//     'categoryImage': 'url_to_image_for_furniture',
//   });

// // Add category 10: Jewellery
//   await categories.doc('prd_cat_10').set({
//     'categoryName': 'Jewellery',
//     'categoryImage': 'url_to_image_for_jewellery',
//   });

// // Add category 11: Luggage Bags
//   await categories.doc('prd_cat_11').set({
//     'categoryName': 'Luggage Bags',
//     'categoryImage': 'url_to_image_for_luggage_bags',
//   });

// // Add category 12: Packaging
//   await categories.doc('prd_cat_12').set({
//     'categoryName': 'Packaging',
//     'categoryImage': 'url_to_image_for_packaging',
//   });

// // Add category 13: Tools
//   await categories.doc('prd_cat_13').set({
//     'categoryName': 'Tools',
//     'categoryImage': 'url_to_image_for_tools',
//   });

// // Add category 14: Grocery
//   await categories.doc('prd_cat_14').set({
//     'categoryName': 'Grocery',
//     'categoryImage': 'url_to_image_for_grocery',
//   });

// // Add category 15: Sport
//   await categories.doc('prd_cat_15').set({
//     'categoryName': 'Sport',
//     'categoryImage': 'url_to_image_for_sport',
//   });

// // Add category 16: Medicine
//   await categories.doc('prd_cat_16').set({
//     'categoryName': 'Medicine',
//     'categoryImage': 'url_to_image_for_medicine',
//   });
}

class CategoryWidget extends StatelessWidget {
  final Map<String, dynamic> data;

  const CategoryWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('categoryName: ${data['brandName']}'),
        Image(image: NetworkImage(data['bannerImage'])),
        // Text('categoryImage: ${data['categoryImage']}'),
        const SizedBox(height: 16),
      ],
    );
  }
}

Future<void> addProducts() async {
  CollectionReference categories =
      FirebaseFirestore.instance.collection('product_items');

  String generateRandom3DigitNumber() {
    Random random = Random();
    return random.nextInt(900).toString() + 100.toString();
  }

  String randomUID = DateTime.now().millisecondsSinceEpoch.toString() +
      generateRandom3DigitNumber();

  await categories.doc(randomUID).set(
    {
      // main Category
      'prdItemCategory': 'Mobiles',
      'pid': randomUID,

      // basic infos for thumbnail

      'itemThumbnail':
          'https://firebasestorage.googleapis.com/v0/b/msoko-seller.appspot.com/o/items%2Fproducts%2FrealmeNarzo.png?alt=media&token=1997dfa4-c840-4753-81ff-ec9c3356aa7a',
      'itemName':
          'realme narzo N53 (Feather Black, 4GB+64GB) 33W Segment Fastest Charging | Slimmest Phone in Segment | 90 Hz Smooth Display',
      'itemSubCategory': 'Smartphone',
      'itemMrp': 10999,
      'itemShippingCharge': 100,
      'itemDiscountPercentage': 18,
      'itemOrderCount': 40,

      // // indetails
      // 'itemImage1':
      //     'https://m.media-amazon.com/images/W/MEDIAX_792452-T1/images/I/71DSxfKzkJL._SX679_.jpg',
      // 'itemImage2':
      //     'https://m.media-amazon.com/images/W/MEDIAX_792452-T1/images/I/71q9IlpreaL._SX679_.jpg',
      // 'itemImage3':
      //     'https://m.media-amazon.com/images/W/MEDIAX_792452-T1/images/I/71IfqYJ8reL._SX679_.jpg',
      'itemImages': {
        'itemImage1':
            'https://m.media-amazon.com/images/W/MEDIAX_792452-T1/images/I/71DSxfKzkJL._SX679_.jpg',
        'itemImage2':
            'https://m.media-amazon.com/images/W/MEDIAX_792452-T1/images/I/71q9IlpreaL._SX679_.jpg',
        'itemImage3':
            'https://m.media-amazon.com/images/W/MEDIAX_792452-T1/images/I/71IfqYJ8reL._SX679_.jpg',
      },

      // specs/Highlights
      'ram': '4',
      'rom': '64',
      'processor': 'Media Tek Helio P35 ❘ Octa Core 2.3 GHz',
      'rearCamera': '13 MP + 2MP',
      'frontCamera': '5 MP',
      'display': '6.5 inch',
      'battery': '5000 MAh',
      'networkType': '4G',
      'simType': 'Dual Sim',
      'isExpandableStorage': false,
      'isAudioJack': false,
      'isQuickCharging': false,
      'inTheBox':
          'USB Cable, Adaptor, cable, Mobile Phone, Ejection Pin, Manual.',

      // ratings and reviews
    },
  );
}
