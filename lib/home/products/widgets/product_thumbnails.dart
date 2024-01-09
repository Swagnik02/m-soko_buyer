import 'package:flutter/material.dart';
import 'package:m_soko/common/utils.dart';
import 'package:m_soko/home/products/screens/productDetailsPage/product_item_detail_page.dart';
import 'package:m_soko/models/product_model.dart';
import 'package:m_soko/navigation/page_transitions.dart';
import 'dart:developer';

class ProductThumbnail extends StatelessWidget {
  final String itemPid;
  final String itemThumbnail;
  final String itemName;
  final String itemSubCategory;
  final double itemMrp;
  final String itemShippingCharge;
  final double? itemDiscountPercentage;
  final String itemOrderCount;

  const ProductThumbnail({
    super.key,
    required this.itemPid,
    required this.itemThumbnail,
    required this.itemName,
    required this.itemSubCategory,
    required this.itemMrp,
    required this.itemShippingCharge,
    required this.itemOrderCount,
    this.itemDiscountPercentage,
  });

  @override
  Widget build(BuildContext context) {
    double finalcost = itemMrp - (itemMrp * (itemDiscountPercentage! / 100));
    return GestureDetector(
      onTap: () async {
        ProductModel? productModel = await collectProductData(itemPid);
        if (productModel != null) {
          Navigator.of(context).push(PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) {
              return ProductItemDetailPage(
                pId: itemPid,
                productModel: productModel,
              );
            },
            transitionsBuilder: customTransition(const Offset(0, 0)),
          ));
        } else {
          // Handle the case when no product data is available
          log('No product data available for $itemPid');
        }
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
                      image: NetworkImage(itemThumbnail),
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
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    '${GlobalUtil.currencySymbol} ${finalcost.floor()}',
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
                      overflow: TextOverflow.ellipsis,
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
