import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:m_soko/common/colors.dart';
import 'package:m_soko/home/products/products_bloc.dart';
import 'package:m_soko/home/products/widgets/product_thumbnails.dart';
import 'package:m_soko/home/products/widgets/products_advertisement.dart';
import 'package:m_soko/home/products/widgets/sortby_filters_topbar.dart';

class ResultPage extends StatelessWidget {
  final String keyword;
  final bool isSearchResults;
  ResultPage({
    required this.keyword,
    required this.isSearchResults,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstants.bgColour,
        appBar: AppBar(
          title: Text(keyword),
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.camera_alt_outlined)),
            IconButton(onPressed: () {}, icon: Icon(Icons.mic)),
            IconButton(onPressed: () {}, icon: Icon(CupertinoIcons.cart)),
          ],
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  topBar(context),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: advertisementBlock(),
                  ),
                  isSearchResults
                      ? _searchBody(keyword)
                      : _categorisedBody(keyword),
                ],
              )),
        ),
      ),
    );
  }
}

Widget _searchBody(String searchKeyword) {
  return FutureBuilder<List<Map<String, dynamic>>>(
    future: futureSearchResultProducts(searchKeyword),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const CircularProgressIndicator();
      } else if (snapshot.data == null || snapshot.data!.isEmpty) {
        return const Center(child: Text('No data found'));
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
                itemThumbnail: (products[index]['itemThumbnail']),
                itemSubCategory: (products[index]['itemSubCategory']),
                itemName: (products[index]['itemName']),
                itemMrp: (products[index]['itemMrp']),
                itemShippingCharge:
                    (products[index]['itemShippingCharge']).toString(),
                itemDiscountPercentage: (products[index]
                    ['itemDiscountPercentage']),
                itemOrderCount: (products[index]['itemOrderCount']).toString(),
              );
            },
          ),
        );
      }
    },
  );
}

Widget _categorisedBody(String title) {
  return FutureBuilder<List<Map<String, dynamic>>>(
    future: futureCheckSelectedCategoryProducts(title),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const CircularProgressIndicator();
      } else if (snapshot.data == null || snapshot.data!.isEmpty) {
        return const Center(child: Text('No data found'));
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
                itemThumbnail: (products[index]['itemThumbnail']),
                itemSubCategory: (products[index]['itemSubCategory']),
                itemName: (products[index]['itemName']),
                itemMrp: (products[index]['itemMrp']),
                itemShippingCharge:
                    (products[index]['itemShippingCharge']).toString(),
                itemDiscountPercentage: (products[index]
                    ['itemDiscountPercentage']),
                itemOrderCount: (products[index]['itemOrderCount']).toString(),
              );
            },
          ),
        );
      }
    },
  );
}
