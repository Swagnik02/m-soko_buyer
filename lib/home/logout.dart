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

  // Add category 1
  await categories.doc('prd_cat_01').set({
    'categoryName': 'Electronics',
    'categoryImage': 'url_to_image_for_electronics',
  });

  // Add category 2
  await categories.doc('prd_cat_02').set({
    'categoryName': 'Mobiles',
    'categoryImage': 'url_to_image_for_mobiles',
  });

  // Show a snackbar or print a message to indicate success
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
        Text('categoryImage: ${data['categoryImage']}'),
        SizedBox(height: 16),
      ],
    );
  }
}
