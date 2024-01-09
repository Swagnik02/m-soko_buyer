import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:m_soko/home/products/products_bloc.dart';
import 'package:m_soko/home/products/screens/all_categories_page.dart';
import 'package:m_soko/home/products/widgets/filter_items.dart';
import 'package:m_soko/home/products/widgets/products_advertisement.dart';
import 'package:m_soko/home/products/widgets/products_main_categories.dart';
import 'package:m_soko/home/products/widgets/recently_viewed.dart';
import 'package:m_soko/home/products/widgets/search_box_widget.dart';
import 'package:m_soko/navigation/page_transitions.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(8, 15, 8, 10),
          child: Column(
            children: [
              // search box
              searchBox(context, false),
              const SizedBox(height: 15),
              // categories
              _mainCategories(),
              const SizedBox(height: 15),
              // Advertisement
              advertisementBlock(),
              const SizedBox(height: 12),
              // Filters
              _filters(context),
              // const SizedBox(height: 15),
              // // 2nd Category
              recentlyViewed(false),
              // const SizedBox(height: 15),
              // // top rated
              _topRated(),

              // const SizedBox(height: 15),
            ],
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

  Widget _filters(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        FilterItem(
          label: 'Recently Viewed',
          onPressedAction: () {
            Fluttertoast.showToast(msg: 'Recently Viewed');
          },
          isSelected: true,
        ),
        FilterItem(
            label: 'Categories',
            onPressedAction: () {
              Navigator.of(context).push(PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) {
                  return const AllCategoriesPage();
                },
                transitionsBuilder: customTransition(const Offset(0, 0)),
              ));
            }),
        FilterItem(
            label: 'Top Offers',
            onPressedAction: () {
              Fluttertoast.showToast(msg: 'Top Offers');
            }),
        FilterItem(
            label: 'New',
            onPressedAction: () {
              Fluttertoast.showToast(msg: 'New');
            }),
      ],
    );
  }
}

Widget _topRated() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Padding(
        padding: EdgeInsets.only(left: 8.0, top: 10),
        child: Text(
          'Top Rated',
          textAlign: TextAlign.start,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      recentlyViewed(false),
    ],
  );
}
