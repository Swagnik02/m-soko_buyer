import 'package:flutter/material.dart';

class CategorizedOfferedProducts extends StatefulWidget {
  final String title;
  final int discountInPercentage;

  const CategorizedOfferedProducts({
    super.key,
    required this.title,
    required this.discountInPercentage,
  });

  @override
  State<CategorizedOfferedProducts> createState() =>
      _CategorizedOfferedProductsState();
}

class _CategorizedOfferedProductsState
    extends State<CategorizedOfferedProducts> {
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
