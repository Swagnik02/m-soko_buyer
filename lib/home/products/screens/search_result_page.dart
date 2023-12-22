import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:m_soko/home/products/widgets/product_thumbnails.dart';
import 'package:m_soko/home/products/widgets/products_advertisement.dart';

class SearchResultPage extends StatelessWidget {
  final String searchKeyword;

  SearchResultPage({required this.searchKeyword});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(searchKeyword),
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
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: advertisementBlock(),
                  ),
                  _searchBody(searchKeyword),
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
    builder: (context, snapshot)

        // Product Thumbnail

        {
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

Future<List<Map<String, dynamic>>> futureSearchResultProducts(
    String category) async {
  var querySnapshot =
      await FirebaseFirestore.instance.collection('product_items').get();

  var filteredDocs = querySnapshot.docs
      .where((doc) =>
          doc['itemName'].toLowerCase().contains(category.toLowerCase()) ||
          doc['itemSubCategory']
              .toLowerCase()
              .contains(category.toLowerCase()) ||
          doc['prdItemCategory'].toLowerCase().contains(category.toLowerCase()))
      .toList();

  return filteredDocs.map((doc) {
    return {
      // main Category
      'prdItemCategory': doc['prdItemCategory'],
      'pid': doc['pid'],

      // basic infos for thumbnail
      'itemThumbnail': doc['itemThumbnail'],
      'itemName': doc['itemName'],
      'itemSubCategory': doc['itemSubCategory'],
      'itemMrp': doc['itemMrp'],
      'itemShippingCharge': doc['itemShippingCharge'],
      'itemDiscountPercentage': doc['itemDiscountPercentage'],
      'itemOrderCount': doc['itemOrderCount'],
    };
  }).toList();
}
