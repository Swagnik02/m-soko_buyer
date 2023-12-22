import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            List<Map<String, dynamic>> searchResults = snapshot.data!;
            // Render your search results using searchResults
            return ListView.builder(
              itemCount: searchResults.length,
              itemBuilder: (context, index) {
                var result = searchResults[index];
                // Build your result item UI here
                return ListTile(
                  title: Text(result['itemName']),
                  subtitle: Text(result['itemSubCategory']),
                  // Add more details as needed
                );
              },
            );
          }
        },
      ),
    );
  }
}
