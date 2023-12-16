import 'package:flutter/material.dart';
import 'package:m_soko/common/utils.dart';
import 'package:m_soko/home/products/screens/product_item_detail_page.dart';
import 'package:m_soko/main.dart';
import 'package:m_soko/navigation/page_transitions.dart';

class ProductThumbnail extends StatelessWidget {
  final String itemImage;
  final String itemName;
  final String itemSubCategory;
  final String itemPrice;
  final String itemShippingCharge;
  final String itemDiscountPercentage;
  final String itemOrderCount;

  ProductThumbnail({
    required this.itemImage,
    required this.itemName,
    required this.itemSubCategory,
    required this.itemPrice,
    required this.itemShippingCharge,
    required this.itemOrderCount,
    this.itemDiscountPercentage = '',
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            return ProductItemDetailPage(
              title: itemName,
              discountInPercentage: 80,
            );
          },
          transitionsBuilder: customTransition(const Offset(0, 0)),
        ));
      },
      child: Material(
        elevation: 4,
        borderRadius: BorderRadius.circular(6),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 9),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Container(
                  width: 160,
                  height: 160,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    image: DecorationImage(
                      image: AssetImage(itemImage),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              // SizedBox(height: 8),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    itemSubCategory,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                    ),
                  ),
                  Text(
                    itemName,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    '${GlobalUtil.currencySymbol} $itemPrice',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 19,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    'Shipping per box: ${GlobalUtil.currencySymbol}$itemShippingCharge',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '$itemDiscountPercentage% off',
                        style: const TextStyle(
                          color: Colors.green,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '$itemOrderCount Orders',
                        style: const TextStyle(
                          color: Colors.black38,
                          fontSize: 13,
                        ),
                      ),
                    ],
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
