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
              const SizedBox(height: 15),
              // Filters
              _filters(),
              const SizedBox(height: 15),
              // 2nd Category
              _secondCategory(),
              const SizedBox(height: 15),
              // top rated
              _topRated(),
              const SizedBox(height: 15),
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
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          ProductsMainCategoryWidget(
            imagePath: 'assets/soko-logo_circle.png',
            categoryName: 'Electronics',
          ),
          ProductsMainCategoryWidget(
            imagePath: 'assets/soko-logo_circle.png',
            categoryName: 'Electronics',
          ),
          ProductsMainCategoryWidget(
            imagePath: 'assets/soko-logo_circle.png',
            categoryName: 'Electronics',
          ),
          ProductsMainCategoryWidget(
            imagePath: 'assets/soko-logo_circle.png',
            categoryName: 'Electronics',
          ),
          ProductsMainCategoryWidget(
            imagePath: 'assets/soko-logo_circle.png',
            categoryName: 'Electronics',
          ),
          ProductsMainCategoryWidget(
            imagePath: 'assets/soko-logo_circle.png',
            categoryName: 'Electronics',
          ),
          ProductsMainCategoryWidget(
            imagePath: 'assets/soko-logo_circle.png',
            categoryName: 'Electronics',
          ),
          ProductsMainCategoryWidget(
            imagePath: 'assets/soko-logo_circle.png',
            categoryName: 'Electronics',
          ),
        ],
      ),
    );
  }

  Widget _advertisement() {
    return Container();
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
}
