import 'package:flutter/material.dart';
import 'package:m_soko/home/products/widgets/products_main_categories.dart';

Widget recentlyViewed(bool showLabel) {
  return Container(
    // height: 200,
    width: double.infinity,
    // color: Colors.red,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          showLabel ? 'Recently Viewed' : '',
          style: TextStyle(
            fontSize: showLabel ? 23 : 10,
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 5),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ProductsMainCategoryWidget(
                  imagePath: 'assets/tests/Mobiles.png',
                  categoryName: 'Mobiles',
                  index: 2,
                ),
                ProductsMainCategoryWidget(
                  imagePath: 'assets/tests/smartWatch.png',
                  categoryName: 'Smart Watches',
                  index: 2,
                ),
                ProductsMainCategoryWidget(
                  imagePath: 'assets/tests/Headphones.png',
                  categoryName: 'Headphones',
                  index: 2,
                ),
                ProductsMainCategoryWidget(
                  imagePath: 'assets/tests/Laptops.png',
                  categoryName: 'Laptops',
                  index: 2,
                ),
              ],
            ),
          ),
        )
      ],
    ),
  );
}
