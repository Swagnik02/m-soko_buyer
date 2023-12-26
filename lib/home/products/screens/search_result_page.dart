import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:m_soko/common/colors.dart';
import 'package:m_soko/home/products/products_bloc.dart';
import 'package:m_soko/home/products/widgets/product_thumbnails.dart';
import 'package:m_soko/home/products/widgets/products_advertisement.dart';

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
  bool isFiltered = false;
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

  Widget filtersBottomSheet() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 25),
      child: SizedBox(
        // height: 270,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Filter',
              style: TextStyle(fontSize: 20),
            ),
            Divider(),
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Text('Price'),
                  // Dropdown for Max Price
                  DropdownButton<int>(
                    items: [
                      DropdownMenuItem(value: 100, child: Text('100'))
                    ], // Replace with your actual items
                    onChanged: (value) {
                      // Handle the change
                    },
                  ),
                  // Dropdown for Min Price
                  DropdownButton<int>(
                    items: [
                      DropdownMenuItem(value: 50, child: Text('50'))
                    ], // Replace with your actual items
                    onChanged: (value) {
                      // Handle the change
                    },
                  ),
                  Text('Brand'),
                  // Add your ToggleButtons for Brand

                  Text('Ram'),
                  // Add your ToggleButtons for Ram

                  Text('Rom'),
                  // Add your ToggleButtons for Rom

                  Text('ScreenSize'),
                  // Add your ToggleButtons for ScreenSize

                  TextButton(
                    onPressed: () {
                      setState(() {
                        isFiltered = true;
                      });
                      Navigator.pop(context); // Close the bottom sheet
                    },
                    child: Text('Apply Filter'),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<List<Map<String, dynamic>>> fetchFilteredProducts(
      String keyword) async {
    switch (isFiltered) {
      case true:
        return futureSearchFilterProducts(
          keyword,
          'ratings',
          '4 GB',
          '64 GB',
          '6.5 inch',
        );
      case false:
        return futureSearchResultProducts(keyword);
    }
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

  Future<List<Map<String, dynamic>>> fetchSortedProducts(
      String keyword, isCategory) async {
    switch (currentSortOption) {
      case SortOptions.relevance:
        switch (isCategory) {
          case true:
            return futureCheckSelectedCategoryProducts(widget.keyword);
          case false:
            return futureSearchResultProducts(widget.keyword);
        }
      case SortOptions.popularity:
        break;
      case SortOptions.priceHighToLow:
        return sortByPrice(widget.keyword, true);
      case SortOptions.priceLowToHigh:
        return sortByPrice(widget.keyword, false);
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
          if (value != null) {
            Navigator.pop(context);
            setState(() {
              currentSortOption = value;
            });
          }
        },
      ),
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
                  return filtersBottomSheet();
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
      // future: fetchSortedProducts(searchKeyword, false),
      future: fetchFilteredProducts(searchKeyword),
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
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: fetchSortedProducts(title, true),
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
}
