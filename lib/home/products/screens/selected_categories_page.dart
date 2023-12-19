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
          physics: BouncingScrollPhysics(),
          child: Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                children: [
                  _topBar(context),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: advertisement_block(),
                  ),
                  _mainBody(),
                ],
              )),
        ),
      ),
    );
  }

  Widget _topBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              showModalBottomSheet<void>(
                context: context,
                builder: (BuildContext context) {
                  return SizedBox(
                    height: 200,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          const Text('Sort by'),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 3.0),
              child: Container(
                height: 54,
                alignment: Alignment.center,
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Sort by'),
                    Icon(Icons.keyboard_arrow_down_sharp, size: 20.0),
                  ],
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {
              showModalBottomSheet<void>(
                context: context,
                builder: (BuildContext context) {
                  return SizedBox(
                    height: 200,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          const Text('Filters'),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 3.0),
              child: Container(
                height: 54,
                alignment: Alignment.center,
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Filters'),
                    Icon(Icons.keyboard_arrow_down_sharp, size: 20.0),
                  ],
                ),
              ),
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
            height: (products.length / 2) * 700,
            child: GridView.builder(
              primary: false,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.58,
                crossAxisSpacing: 18.0,
                mainAxisSpacing: 20.0,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                return ProductThumbnail(
                  itemPid: (products[index]['pid']),
                  itemImage: (products[index]['itemImage']),
                  itemSubCategory: (products[index]['itemSubCategory']),
                  itemName: (products[index]['itemName']),
                  itemPrice: (products[index]['itemPrice']),
                  itemShippingCharge:
                      (products[index]['itemShippingCharge']).toString(),
                  itemDiscountPercentage: (products[index]
                      ['itemDiscountPercentage']),
                  itemOrderCount:
                      (products[index]['itemOrderCount']).toString(),
                );
              },
            ),
          );
        }
      },
    );
  }
}
