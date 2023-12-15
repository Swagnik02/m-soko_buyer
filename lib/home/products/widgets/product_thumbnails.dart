import 'package:flutter/material.dart';
import 'package:m_soko/home/products/screens/product_item_detail_page.dart';
import 'package:m_soko/navigation/page_transitions.dart';

class ProductThumbnail extends StatelessWidget {
  final String prdCategoryImage;
  final String prdCategory;
  final int discountPercentage;

  ProductThumbnail({
    this.prdCategoryImage = 'assets/tests/T-shirts.png',
    required this.prdCategory,
    this.discountPercentage = 70,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            return ProductItemDetailPage(
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
          padding: EdgeInsets.all(8),
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
              SizedBox(height: 8),
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
