import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m_soko/authentication/auth_services/bloc/auth_bloc.dart';
import 'package:m_soko/authentication/auth_services/bloc/auth_event.dart';

class LogoutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Logout'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('product_categories')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          var documents = snapshot.data?.docs;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image(
                image: NetworkImage(
                    'https://firebasestorage.googleapis.com/v0/b/msoko-seller.appspot.com/o/prd_cat_medicine.png?alt=media&token=f0445bb0-dbfc-4314-9790-ea0a3c2bcfa7'),
              ),
              ElevatedButton(
                onPressed: () {
                  // Call a function to add categories
                  addCategories();
                },
                child: Text('Add Categories'),
              ),
              TextButton(
                onPressed: () {
                  context.read<AuthBloc>().add(
                        const AuthEventLogOut(),
                      );
                },
                child: Text('Logout'),
              ),
              for (var document in documents!)
                CategoryWidget(data: document.data() as Map<String, dynamic>),
            ],
          );
        },
      ),
    );
  }
}

Future<void> addCategories() async {
  // Reference to the Firestore collection
  CollectionReference categories =
      FirebaseFirestore.instance.collection('product_categories');

// Assuming 'categories' is a reference to your Firebase Firestore collection

// Add category 1: Electronics
  await categories.doc('prd_cat_01').set({
    'categoryName': 'Electronics',
    'categoryImage': 'url_to_image_for_electronics',
  });

// Add category 2: Mobiles
  await categories.doc('prd_cat_02').set({
    'categoryName': 'Mobiles',
    'categoryImage': 'url_to_image_for_mobiles',
  });

// Add category 3: Fashion
  await categories.doc('prd_cat_03').set({
    'categoryName': 'Fashion',
    'categoryImage': 'url_to_image_for_fashion',
  });

// Add category 4: Personal Care
  await categories.doc('prd_cat_04').set({
    'categoryName': 'Personal Care',
    'categoryImage': 'url_to_image_for_personal_care',
  });

// Add category 5: Footwear
  await categories.doc('prd_cat_05').set({
    'categoryName': 'Footwear',
    'categoryImage': 'url_to_image_for_footwear',
  });

// Add category 6: Baby Products
  await categories.doc('prd_cat_06').set({
    'categoryName': 'Baby Products',
    'categoryImage': 'url_to_image_for_baby_products',
  });

// Add category 7: Home
  await categories.doc('prd_cat_07').set({
    'categoryName': 'Home',
    'categoryImage': 'url_to_image_for_home',
  });

// Add category 8: Eyewear
  await categories.doc('prd_cat_08').set({
    'categoryName': 'Eyewear',
    'categoryImage': 'url_to_image_for_eyewear',
  });

// Add category 9: Furniture
  await categories.doc('prd_cat_09').set({
    'categoryName': 'Furniture',
    'categoryImage': 'url_to_image_for_furniture',
  });

// Add category 10: Jewellery
  await categories.doc('prd_cat_10').set({
    'categoryName': 'Jewellery',
    'categoryImage': 'url_to_image_for_jewellery',
  });

// Add category 11: Luggage Bags
  await categories.doc('prd_cat_11').set({
    'categoryName': 'Luggage Bags',
    'categoryImage': 'url_to_image_for_luggage_bags',
  });

// Add category 12: Packaging
  await categories.doc('prd_cat_12').set({
    'categoryName': 'Packaging',
    'categoryImage': 'url_to_image_for_packaging',
  });

// Add category 13: Tools
  await categories.doc('prd_cat_13').set({
    'categoryName': 'Tools',
    'categoryImage': 'url_to_image_for_tools',
  });

// Add category 14: Grocery
  await categories.doc('prd_cat_14').set({
    'categoryName': 'Grocery',
    'categoryImage': 'url_to_image_for_grocery',
  });

// Add category 15: Sport
  await categories.doc('prd_cat_15').set({
    'categoryName': 'Sport',
    'categoryImage': 'url_to_image_for_sport',
  });

// Add category 16: Medicine
  await categories.doc('prd_cat_16').set({
    'categoryName': 'Medicine',
    'categoryImage': 'url_to_image_for_medicine',
  });
}

class CategoryWidget extends StatelessWidget {
  final Map<String, dynamic> data;

  const CategoryWidget({required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('categoryName: ${data['categoryName']}'),
        Image(image: NetworkImage(data['categoryImage'])),
        // Text('categoryImage: ${data['categoryImage']}'),
        SizedBox(height: 16),
      ],
    );
  }
}
