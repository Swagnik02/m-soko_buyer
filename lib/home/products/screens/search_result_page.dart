import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:m_soko/home/products/widgets/product_thumbnails.dart';

class SearchResultPage extends StatelessWidget {
  final String searchKeyword;

  SearchResultPage({required this.searchKeyword});

  Future<List<Map<String, dynamic>>> futureCheckSelectedCategoryProducts(
      String category) async {
    var querySnapshot =
        await FirebaseFirestore.instance.collection('product_items').get();

    var filteredDocs = querySnapshot.docs
        .where((doc) =>
            doc['itemName'].toLowerCase().contains(category.toLowerCase()) ||
            doc['itemSubCategory']
                .toLowerCase()
                .contains(category.toLowerCase()) ||
            doc['prdItemCategory']
                .toLowerCase()
                .contains(category.toLowerCase()))
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Results'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: futureCheckSelectedCategoryProducts(searchKeyword),
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
                    itemOrderCount:
                        (products[index]['itemOrderCount']).toString(),
                  );
                },
              ),
            );
          }
        },

        // ListView
        // {
        //   if (snapshot.connectionState == ConnectionState.waiting) {
        //     return CircularProgressIndicator();
        //   } else if (snapshot.hasError) {
        //     return Text('Error: ${snapshot.error}');
        //   } else {
        //     List<Map<String, dynamic>> searchResults = snapshot.data!;
        //     // Render your search results using searchResults
        //     return ListView.builder(
        //       itemCount: searchResults.length,
        //       itemBuilder: (context, index) {
        //         var result = searchResults[index];
        //         // Build your result item UI here
        //         return ListTile(
        //           title: Text(result['itemName']),
        //           subtitle: Text(result['itemSubCategory']),
        //           // Add more details as needed
        //         );
        //       },
        //     );
        //   }
        // },
      ),
    );
  }
}
