import 'package:flutter/material.dart';

class ProductItemDetailPage extends StatefulWidget {
  final String pId;

  const ProductItemDetailPage({
    super.key,
    required this.pId,
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
          title: Text(widget.pId),
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
