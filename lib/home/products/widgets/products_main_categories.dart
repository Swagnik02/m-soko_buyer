import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:m_soko/common/colors.dart';
import 'package:m_soko/home/products/screens/selected_categories_page.dart';
import 'package:m_soko/navigation/page_transitions.dart';

class ProductsMainCategoryWidget extends StatelessWidget {
  final String imagePath;
  final String categoryName;
  final int index;

  const ProductsMainCategoryWidget({
    Key? key,
    required this.imagePath,
    required this.categoryName,
    this.index = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            return SelectedCategoryPage(
              title: categoryName,
            );
          },
          transitionsBuilder: customTransition(const Offset(0, 0)),
        ));
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: (() {
          switch (index) {
            case 0:
              return _allCategoryStyleSmallIcons();
            case 1:
              return _allCategoryGridStyle();
            case 2:
              return _categoryRecentlyViewStyle();
            default:
              return _allCategoryStyleSmallIcons();
          }
        })(),
      ),
    );
  }

  Widget _categoryRecentlyViewStyle() {
    return Container(
      width: 120,
      height: 130,
      child: Material(
        elevation: 2,
        borderRadius: BorderRadius.circular(10),
        // color: ColorConstants.yellow50,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            index == 2
                ? Image.asset(
                    imagePath,
                    width: 110,
                    height: 110,
                  )
                : Image(
                    image: NetworkImage(imagePath),
                    width: 110,
                    height: 110,
                  ),
            // SizedBox(height: 8),
            Text(
              categoryName,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _allCategoryStyleSmallIcons() {
    return Container(
      width: 76,
      height: 82,
      decoration: BoxDecoration(
        color: ColorConstants.yellow50,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            image: NetworkImage(imagePath),
            width: 50,
            height: 50,
          ),
          SizedBox(height: 8),
          Text(
            categoryName,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11),
          ),
        ],
      ),
    );
  }

  Widget _allCategoryGridStyle() {
    return Column(
      children: [
        Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            color: ColorConstants.blue50,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Image(
            image: NetworkImage(imagePath),
            width: 60,
            height: 60,
          ),
        ),
        SizedBox(height: 2),
        Text(
          categoryName,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
