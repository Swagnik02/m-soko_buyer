// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:m_soko/home/products/products_bloc.dart';
import 'package:m_soko/home/products/widgets/products_main_categories.dart';
import 'package:m_soko/home/products/widgets/recently_viewed.dart';

class AllCategoriesPage extends StatefulWidget {
  const AllCategoriesPage({super.key});

  @override
  State<AllCategoriesPage> createState() => _AllCategoriesPageState();
}

class _AllCategoriesPageState extends State<AllCategoriesPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: Colors.white,
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          // actions: [Icon(Icons.search)],
          title: const Text(
            'All Categories',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.center,
                end: Alignment.bottomCenter,
                colors: [Colors.white, Colors.blue],
              ),
            ),
            child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _mainCategories(),
                    recentlyViewed(true),
                    _specialOffers(),
                  ],
                )),
          ),
        ),
      ),
    );
  }

  Widget _mainCategories() {
    return FutureBuilder(
      future: fetchCategoriesFromFirestore(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          var categories = snapshot.data as List<Map<String, dynamic>>;
          return Container(
            // color: Colors.red,
            height: 400,
            child: GridView.builder(
              primary: false,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                // crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              // scrollDirection: Axis.vertical,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return ProductsMainCategoryWidget(
                  imagePath: categories[index]['categoryImage'],
                  categoryName: categories[index]['categoryName'],
                  index: 1,
                );
              },
            ),
          );
        }
      },
    );
  }

  Widget _specialOffers() {
    return Container(
      // color: Colors.red,
      height: 530,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Special Offers',
            style: TextStyle(
              fontSize: 23,
            ),
          ),
          _customGrid(),
        ],
      ),
    );
  }

  Widget _customGrid() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SpecialOfferedCategory(
              prdCategoryImage: 'assets/tests/T-shirts.png',
              prdCategory: 'T-shirts',
              discountPercentage: 70,
            ),
            SpecialOfferedCategory(
              prdCategoryImage: 'assets/tests/T-shirts.png',
              prdCategory: 'T-shirts',
              discountPercentage: 70,
            ),
          ],
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SpecialOfferedCategory(
              prdCategoryImage: 'assets/tests/T-shirts.png',
              prdCategory: 'T-shirts',
              discountPercentage: 70,
            ),
            SpecialOfferedCategory(
              prdCategoryImage: 'assets/tests/T-shirts.png',
              prdCategory: 'T-shirts',
              discountPercentage: 70,
            ),
          ],
        ),
      ],
    );
  }
}
