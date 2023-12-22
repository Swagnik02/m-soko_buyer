import 'package:flutter/material.dart';
import 'package:m_soko/common/colors.dart';
import 'package:m_soko/home/products/screens/categorised_offered_products.dart';
import 'package:m_soko/home/products/screens/search_result_page.dart';
import 'package:m_soko/navigation/page_transitions.dart';

class ProductsMainCategoryWidget extends StatelessWidget {
  final String imagePath;
  final String categoryName;
  final int index;

  const ProductsMainCategoryWidget({
    super.key,
    required this.imagePath,
    required this.categoryName,
    this.index = 0,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            return ResultPage(
              keyword: categoryName,
              isSearchResults: false,
            );
          },
          transitionsBuilder: customTransition(const Offset(0, 0)),
        ));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
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
        color: const Color(0x1F0E6E6E6),
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
            Text(
              categoryName,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 2),
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
          const SizedBox(height: 8),
          Text(
            categoryName,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 11),
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
        const SizedBox(height: 2),
        Text(
          categoryName,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

class SpecialOfferedCategory extends StatelessWidget {
  final String prdCategoryImage;
  final String prdCategory;
  final int discountPercentage;

  const SpecialOfferedCategory({
    super.key,
    required this.prdCategoryImage,
    required this.prdCategory,
    required this.discountPercentage,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            return CategorizedOfferedProducts(
              title: prdCategory,
              discountInPercentage: discountPercentage,
            );
          },
          transitionsBuilder: customTransition(const Offset(0, 0)),
        ));
      },
      child: Container(
        width: 180,
        height: 230,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF51C5F6), Color.fromRGBO(8, 13, 148, 1)],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 163,
                height: 145,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  image: DecorationImage(
                    image: AssetImage(prdCategoryImage),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    prdCategory,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Upto $discountPercentage% off',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
