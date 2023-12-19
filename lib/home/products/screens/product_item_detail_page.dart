import 'package:flutter/material.dart';
import 'package:m_soko/models/product_model.dart';

class ProductItemDetailPage extends StatefulWidget {
  final String pId;
  final ProductModel productModel;

  const ProductItemDetailPage({
    Key? key,
    required this.pId,
    required this.productModel,
  }) : super(key: key);

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
          child: Column(
            children: [
              Text(widget.productModel.name ?? 'Name not available'),
              Text(widget.productModel.subCategory ??
                  'Subcategory not available'),
              Text(widget.productModel.price?.toString() ??
                  'Price not available'),
            ],
          ),
        ),
      ),
    );
  }
}
