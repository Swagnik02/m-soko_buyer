import 'dart:developer' as devtools show log;
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:m_soko/models/user_model.dart';

String lorem =
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.';

class LogoutScreen extends StatelessWidget {
  LogoutScreen({super.key});

  String get userId => FirebaseAuth.instance.currentUser?.uid ?? "";
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
                onPressed: () async {
                  // Call a function to add categories
                  // addCategories();
                  // addProducts();
                  // updateUserData();
                  // someFunction();
                  FirebaseAuth.instance.signOut();
                  Fluttertoast.showToast(
                      msg: '${UserDataService().userModel?.userName} ');
                  // Call fetchUserData to update the user data
                  // fecthUsersData(
                  //     FirebaseAuth.instance.currentUser?.email ?? "");
                  // addProductsItems();
                },
                child: const Text('Add Categories'),
              ),
              TextButton(
                onPressed: () {
                  devtools.log(userId);
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

Future<void> fecthUsersData(String email) async {
  try {
    CollectionReference usersCollection =
        FirebaseFirestore.instance.collection('users');
    QuerySnapshot querySnapshot =
        await usersCollection.where('email', isEqualTo: email).get();

    if (querySnapshot.docs.isNotEmpty) {
      for (QueryDocumentSnapshot productDocument in querySnapshot.docs) {
        Map<String, dynamic> productData =
            productDocument.data() as Map<String, dynamic>;

        devtools.log('Users Data for $email: $productData');
      }
    } else {
      devtools.log('No user found with email: $email');
    }
  } catch (e) {
    devtools.log('Error collecting user data: $e');
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

Future<void> updateUserData() async {
  try {
    // Replace 'users' with your actual collection name
    CollectionReference<Map<String, dynamic>> usersCollection =
        FirebaseFirestore.instance.collection('users');

    // Use the user's email as the document ID
    String userEmail = FirebaseAuth.instance.currentUser?.email ?? "";
    DocumentReference<Map<String, dynamic>> userDocRef =
        usersCollection.doc(userEmail);

    Map<String, dynamic> userData = {
      'uid': FirebaseAuth.instance.currentUser?.uid ?? "",
      'mobile': FirebaseAuth.instance.currentUser?.phoneNumber ?? "",
      'email': FirebaseAuth.instance.currentUser?.email ?? "",
      'userName': FirebaseAuth.instance.currentUser?.displayName ?? "",
      'city': 'Kolkata',
      'pin': '731303',
      'state': 'West Bengal',
      'country': 'India',
    };

    // Use set with the merge option to create or update the document
    await userDocRef.set(userData, SetOptions(merge: true));
    print('Document with ID $userEmail updated or created successfully!');
  } catch (e) {
    // Handle error appropriately
    print('Error updating or creating user data: $e');
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
// import 'dart:developer' as devtools show log;
// import 'dart:math';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:get/get.dart';
// import 'package:m_soko/common/utils.dart';
// import 'package:m_soko/models/user_model.dart';
// import 'package:m_soko/routes/app_routes.dart';

// String lorem =
//     'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.';

// class LogoutScreen extends StatelessWidget {
//   LogoutScreen({super.key});

//   String get userId => FirebaseAuth.instance.currentUser?.uid ?? "";
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Logout'),
//       ),
//       body: StreamBuilder(
//         stream:
//             FirebaseFirestore.instance.collection('product_items').snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const CircularProgressIndicator();
//           }

//           if (snapshot.hasError) {
//             return Text('Error: ${snapshot.error}');
//           }

//           // var documents = snapshot.data?.docs;

//           return Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Image(
//               //   image: NetworkImage(
//               // 'https://firebasestorage.googleapis.com/v0/b/msoko-
//               // seller.appspot.com/o/ad_banners%2Fprd_ad_1.png?
//               // alt=media&token=0dda43dd-29ed-4f71-a4c2-88804f5c463f'),
//               // ),
//               ElevatedButton(
//                 onPressed: () async {
//                   // Call a function to add categories
//                   // addCategories();
//                   // addProducts();
//                   // updateUserData();
//                   // someFunction();
//                   Fluttertoast.showToast(
//                       msg: '${UserDataService().userModel?.pin} ');
//                   // Call fetchUserData to update the user data
//                   // fecthUsersData(
//                   //     FirebaseAuth.instance.currentUser?.email ?? "");
//                   // addProductsItems();
//                 },
//                 child: const Text('Add Categories'),
//               ),
//               TextButton(
//                 onPressed: () {
//                   FirebaseAuth.instance
//                       .signOut()
//                       .then((value) => Get.offAllNamed(AppRoutes.loginScreen));
//                   Fluttertoast.showToast(msg: 'Logged Out');
//                 },
//                 child: const Text('Logout'),
//               ),
//               // for (var document in documents!)
//               //   CategoryWidget(data: document.data() as Map<String, dynamic>),
//               // for (var document in documents!)
//               //   ShowProducts(data: document.data() as Map<String, dynamic>),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }

// Future<void> fecthUsersData(String email) async {
//   try {
//     CollectionReference usersCollection = FirebaseFirestore.instance
//         .collection(FirestoreCollections.usersCollection);
//     QuerySnapshot querySnapshot =
//         await usersCollection.where('email', isEqualTo: email).get();

//     if (querySnapshot.docs.isNotEmpty) {
//       for (QueryDocumentSnapshot productDocument in querySnapshot.docs) {
//         Map<String, dynamic> productData =
//             productDocument.data() as Map<String, dynamic>;

//         devtools.log('Users Data for $email: $productData');
//       }
//     } else {
//       devtools.log('No user found with email: $email');
//     }
//   } catch (e) {
//     devtools.log('Error collecting user data: $e');
//   }
// }

// Future<void> addCategories() async {
//   CollectionReference categories =
//       FirebaseFirestore.instance.collection('advertisement');

//   await categories.doc('prop_ad_0').set({
//     'brandName': 'House',
//     'bannerImage':
//         'https://firebasestorage.googleapis.com/v0/b/msoko-seller.appspot.com/o/ad_banners%2Fprop_ad_1.png?alt=media&token=c39ab5c0-26a9-4ffa-96c9-447f188c39c6',
//   });
// }

// class CategoryWidget extends StatelessWidget {
//   final Map<String, dynamic> data;

//   const CategoryWidget({super.key, required this.data});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text('categoryName: ${data['brandName']}'),
//         Image(image: NetworkImage(data['bannerImage'])),
//         // Text('categoryImage: ${data['categoryImage']}'),
//         const SizedBox(height: 16),
//       ],
//     );
//   }
// }

// Future<void> updateUserData() async {
//   try {
//     // Replace FirestoreCollection.usersCollection with your actual collection name
//     CollectionReference<Map<String, dynamic>> usersCollection =
//         FirebaseFirestore.instance
//             .collection(FirestoreCollections.usersCollection);

//     // Use the user's email as the document ID
//     String userEmail = FirebaseAuth.instance.currentUser?.email ?? "";
//     DocumentReference<Map<String, dynamic>> userDocRef =
//         usersCollection.doc(userEmail);

//     Map<String, dynamic> userData = {
//       'uid': FirebaseAuth.instance.currentUser?.uid ?? "",
//       'mobile': FirebaseAuth.instance.currentUser?.phoneNumber ?? "",
//       'email': FirebaseAuth.instance.currentUser?.email ?? "",
//       'userName': FirebaseAuth.instance.currentUser?.displayName ?? "",
//       'city': 'Kolkata',
//       'pin': '731303',
//       'state': 'West Bengal',
//       'country': 'India',
//     };

//     // Use set with the merge option to create or update the document
//     await userDocRef.set(userData, SetOptions(merge: true));
//     print('Document with ID $userEmail updated or created successfully!');
//   } catch (e) {
//     // Handle error appropriately
//     print('Error updating or creating user data: $e');
//   }
// }

// Future<void> addProducts() async {
//   CollectionReference categories =
//       FirebaseFirestore.instance.collection('product_items');

//   String generateRandom3DigitNumber() {
//     Random random = Random();
//     return random.nextInt(900).toString() + 100.toString();
//   }

//   String randomUID = DateTime.now().millisecondsSinceEpoch.toString() +
//       generateRandom3DigitNumber();

//   await categories.doc(randomUID).set(
//     {
//       // main Category
//       'prdItemCategory': 'Mobiles',
//       'pid': randomUID,

//       // basic infos for thumbnail

//       'itemThumbnail':
//           'https://firebasestorage.googleapis.com/v0/b/msoko-seller.appspot.com/o/items%2Fproducts%2FrealmeNarzo.png?alt=media&token=1997dfa4-c840-4753-81ff-ec9c3356aa7a',
//       'itemName':
//           'realme narzo N53 (Feather Black, 4GB+64GB) 33W Segment Fastest Charging | Slimmest Phone in Segment | 90 Hz Smooth Display',
//       'itemSubCategory': 'Smartphone',
//       'itemMrp': 10999,
//       'itemShippingCharge': 100,
//       'itemDiscountPercentage': 18,
//       'itemOrderCount': 40,

//       // // indetails
//       // 'itemImage1':
//       //     'https://m.media-amazon.com/images/W/MEDIAX_792452-T1/images/I/71DSxfKzkJL._SX679_.jpg',
//       // 'itemImage2':
//       //     'https://m.media-amazon.com/images/W/MEDIAX_792452-T1/images/I/71q9IlpreaL._SX679_.jpg',
//       // 'itemImage3':
//       //     'https://m.media-amazon.com/images/W/MEDIAX_792452-T1/images/I/71IfqYJ8reL._SX679_.jpg',
//       'itemImages': {
//         'itemImage1':
//             'https://m.media-amazon.com/images/W/MEDIAX_792452-T1/images/I/71DSxfKzkJL._SX679_.jpg',
//         'itemImage2':
//             'https://m.media-amazon.com/images/W/MEDIAX_792452-T1/images/I/71q9IlpreaL._SX679_.jpg',
//         'itemImage3':
//             'https://m.media-amazon.com/images/W/MEDIAX_792452-T1/images/I/71IfqYJ8reL._SX679_.jpg',
//       },

//       // specs/Highlights
//       'ram': '4',
//       'rom': '64',
//       'processor': 'Media Tek Helio P35 ❘ Octa Core 2.3 GHz',
//       'rearCamera': '13 MP + 2MP',
//       'frontCamera': '5 MP',
//       'display': '6.5 inch',
//       'battery': '5000 MAh',
//       'networkType': '4G',
//       'simType': 'Dual Sim',
//       'isExpandableStorage': false,
//       'isAudioJack': false,
//       'isQuickCharging': false,
//       'inTheBox':
//           'USB Cable, Adaptor, cable, Mobile Phone, Ejection Pin, Manual.',

//       // ratings and reviews
//     },
//   );
// }
