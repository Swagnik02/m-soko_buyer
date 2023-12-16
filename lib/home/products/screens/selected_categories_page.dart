import 'package:flutter/material.dart';
import 'package:m_soko/common/colors.dart';
import 'package:m_soko/home/products/products_bloc.dart';
import 'package:m_soko/home/products/widgets/product_thumbnails.dart';
import 'package:m_soko/home/products/widgets/products_advertisement.dart';

class SelectedCategoryPage extends StatelessWidget {
  final String title;

  SelectedCategoryPage({
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstants.bgColour,
        appBar: AppBar(
          title: Text(
            title,
          ),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            child: Padding(
                padding: EdgeInsets.all(12),
                child: Column(
                  children: [
                    _topBar(),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: advertisement_block(),
                    ),
                    _mainBody(),
                  ],
                )),
          ),
        ),
      ),
    );
  }

  Widget _topBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3.0),
            child: Container(
              height: 54,
              alignment: Alignment.center,
              color: Colors.white,
              child: Text('Sort by'),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3.0),
            child: Container(
              height: 54,
              alignment: Alignment.center,
              color: Colors.white,
              child: Text('Filters'),
            ),
          ),
        ),
      ],
    );
  }

  Widget _mainBody() {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: futureCheckSelectedCategoryProducts(title),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.data == null || snapshot.data!.isEmpty) {
          return Center(child: Text('No data found'));
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          List<Map<String, dynamic>> products = snapshot.data!;
          return Container(
            // color: Colors.red,
            height: (products.length / 2 * 400) - 150,
            child: GridView.builder(
              primary: false,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.58,
                crossAxisSpacing: 18.0,
                mainAxisSpacing: 20.0,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                return ProductThumbnail(
                  itemImage: 'assets/tests/mobiles/realmeNarzo.png',
                  // itemName: (products[index]['prdItemName']),
                  itemSubCategory: 'Smartphone',
                  itemName: 'Realme Narzo',
                  itemPrice: '17000',
                  // itemPrice: (products[index]['prdItemPrice']).toString(),
                  itemShippingCharge: '100',
                  itemDiscountPercentage: '40',
                  itemOrderCount: '40',
                );
              },
            ),
          );
        }
      },
    );
  }
}
