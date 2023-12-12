import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:m_soko/common/colors.dart';
import 'package:m_soko/home/products/widgets/products_categories.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(8, 15, 8, 10),
          child: Column(
            children: [
              // search box
              _searchBox(),
              const SizedBox(height: 15),
              // categories
              _mainCategories(),
              const SizedBox(height: 15),
              // Advertisement
              _advertisement(),
              const SizedBox(height: 8),

              // Filters
              // _filters(),
              // const SizedBox(height: 15),
              // // 2nd Category
              // _secondCategory(),
              // const SizedBox(height: 15),
              // // top rated
              // _topRated(),
              // const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }

  Widget _searchBox() {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: ColorConstants.blue50,
        border: Border.all(color: ColorConstants.blue200),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(CupertinoIcons.search, color: ColorConstants.blue700),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                "Search for products",
                style: TextStyle(
                  fontSize: 19,
                  color: ColorConstants.blue700,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              Icons.camera_alt_outlined,
              color: ColorConstants.blue700,
            ),
          ),
          SizedBox(
            width: 15,
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(CupertinoIcons.mic, color: ColorConstants.blue700),
          ),
        ],
      ),
    );
  }

  Widget _mainCategories() {
    return FutureBuilder(
      // Replace this with your actual method to fetch categories from Firestore
      future: fetchCategoriesFromFirestore(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          var categories = snapshot.data as List<Map<String, dynamic>>;
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: categories.map((category) {
                return ProductsMainCategoryWidget(
                  imagePath: category['categoryImage'],
                  categoryName: category['categoryName'],
                );
              }).toList(),
            ),
          );
        }
      },
    );
  }

  Widget _advertisement() {
    return Container(
      height: 170,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Container(
              height: 150,
              child: PageView.builder(
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Image.asset(
                    'assets/prd_ad_1.png',
                    // fit: BoxFit.cover,
                  );
                },
              ),
            ),
          ),
          // SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              3,
              (index) => buildDotIndicator(index),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDotIndicator(int index) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.blue.withOpacity(index == 0 ? 1 : 0.5),
      ),
    );
  }

  Widget _filters() {
    return Container();
  }

  Widget _secondCategory() {
    return Container();
  }

  Widget _topRated() {
    return Container();
  }

  Future<List<Map<String, dynamic>>> fetchCategoriesFromFirestore() async {
    print('Before Firestore call');
    var querySnapshot =
        await FirebaseFirestore.instance.collection('product_categories').get();
    print('After Firestore call');

    return querySnapshot.docs.map((doc) {
      return {
        'categoryName': doc['categoryName'],
        'categoryImage': doc['categoryImage'],
      };
    }).toList();
  }
}
