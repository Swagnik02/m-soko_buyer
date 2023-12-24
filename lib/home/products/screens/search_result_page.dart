import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:m_soko/common/colors.dart';
import 'package:m_soko/home/products/products_bloc.dart';
import 'package:m_soko/home/products/widgets/product_thumbnails.dart';
import 'package:m_soko/home/products/widgets/products_advertisement.dart';
import 'package:m_soko/models/product_category_model.dart';

enum SortOptions {
  relevance,
  popularity,
  priceHighToLow,
  priceLowToHigh,
}

class ResultPage extends StatefulWidget {
  final String keyword;
  final bool isSearchResults;
  ResultPage({
    required this.keyword,
    required this.isSearchResults,
  });

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  SortOptions currentSortOption = SortOptions.relevance;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstants.bgColour,
        appBar: AppBar(
          title: Text(widget.keyword),
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
                widget.isSearchResults
                    ? _searchBody(widget.keyword)
                    : _categorisedBody(widget.keyword),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget sortOptionsBottomSheet() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 25),
      child: SizedBox(
        height: 270,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Sort by',
              style: TextStyle(fontSize: 20),
            ),
            Divider(),
            Column(
              children: <Widget>[
                buildSortOption(context, SortOptions.relevance, 'Relevance'),
                buildSortOption(context, SortOptions.popularity, 'Popularity'),
                buildSortOption(
                    context, SortOptions.priceHighToLow, 'Price High to Low'),
                buildSortOption(
                    context, SortOptions.priceLowToHigh, 'Price Low to High'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<List<Map<String, dynamic>>> fetchSortedProducts() async {
    switch (currentSortOption) {
      case SortOptions.relevance:
        return futureSearchResultProducts(widget.keyword);
      case SortOptions.popularity:
        // TODO: Implement logic for popularity sorting
        break;
      case SortOptions.priceHighToLow:
        return sortByPriceHighToLow(widget.keyword);
      case SortOptions.priceLowToHigh:
        return sortByPriceLowToHigh(widget.keyword);
    }
    return [];
  }

  Widget buildSortOption(
      BuildContext context, SortOptions option, String label) {
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      title: Text(label),
      trailing: Radio<SortOptions>(
        value: option,
        groupValue: currentSortOption,
        onChanged: (SortOptions? value) {
          // Update the state when the radio button is selected
          if (value != null) {
            Navigator.pop(context);
            setState(() {
              currentSortOption = value;
            });
            // TODO: Call the function to apply sorting logic based on the selected option
            // You might want to modify your product fetching functions accordingly
          }
        },
      ),
      onTap: () {
        // You can also handle the onTap event if needed
        // For example, you might want to close the bottom sheet when a tile is tapped
        Navigator.pop(context);
      },
    );
  }

  Widget topBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              showModalBottomSheet<void>(
                context: context,
                builder: (BuildContext context) {
                  return sortOptionsBottomSheet();
                },
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3.0),
              child: Container(
                height: 54,
                alignment: Alignment.center,
                color: Colors.white,
                child: const Row(
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
                  return const SizedBox(
                    height: 200,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text('Filters'),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3.0),
              child: Container(
                height: 54,
                alignment: Alignment.center,
                color: Colors.white,
                child: const Row(
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

  Widget _categorisedBody(String title) {
    return FutureBuilder<List<ProductsCategoryModel>>(
      future: futureCheckSelectedCategoryProducts(title),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.data == null) {
          log(snapshot.data.toString());
          return const Center(child: Text('No data found'));
        } else if (snapshot.data!.isEmpty) {
          return const Center(child: Text('Data is empty'));
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          List<ProductsCategoryModel> products = snapshot.data!;
          log(products.toString());
          return Container(
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
                ProductsCategoryModel currentProduct = products[index];
                return ProductThumbnail(
                  itemPid: currentProduct.pid,
                  itemThumbnail: currentProduct.itemThumbnail,
                  itemSubCategory: currentProduct.itemSubCategory,
                  itemName: currentProduct.itemName,
                  itemMrp: currentProduct.itemMrp,
                  itemShippingCharge:
                      currentProduct.itemShippingCharge.toString(),
                  itemDiscountPercentage: currentProduct.itemDiscountPercentage,
                  itemOrderCount: currentProduct.itemOrderCount.toString(),
                );
              },
            ),
          );
        }
      },
    );
  }
}
