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
        child: index == 0
            ? Container(
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
              )
            : _allCategoryStyle(),
      ),
    );
  }

  Widget _allCategoryStyle() {
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
