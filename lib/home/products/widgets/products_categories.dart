import 'package:flutter/material.dart';
import 'package:m_soko/common/colors.dart';
import 'package:m_soko/home/products/screens/main_categories_page.dart';

class ProductsMainCategoryWidget extends StatelessWidget {
  final String imagePath;
  final String categoryName;

  const ProductsMainCategoryWidget({
    Key? key,
    required this.imagePath,
    required this.categoryName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => MainCategoryPage(
              title: categoryName,
            ),
          ),
        );
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: Container(
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
        ),
      ),
    );
  }
}
