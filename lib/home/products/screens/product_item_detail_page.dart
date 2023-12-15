import 'package:flutter/material.dart';

class ProductItemDetailPage extends StatefulWidget {
  final String title;
  final int discountInPercentage;

  const ProductItemDetailPage({
    super.key,
    required this.title,
    required this.discountInPercentage,
  });

  @override
  State<ProductItemDetailPage> createState() => ProductItemDetailPageState();
}

class ProductItemDetailPageState extends State<ProductItemDetailPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
              '${widget.title} at upto ${widget.discountInPercentage}% off '),
        ),
        body: Container(

            // logic = filter out the items which have
            // prdDiscount = ${widget.discountInPercentage}
            // and prdCategory = ${widget.title}

            ),
      ),
    );
  }
}
