import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:m_soko/common/colors.dart';
import 'package:m_soko/home/products/products_bloc.dart';
import 'package:m_soko/home/products/widgets/filter_items.dart';
import 'package:m_soko/home/products/widgets/products_main_categories.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(8, 15, 8, 10),
          child: Column(
            children: [
              // search box
              _searchBox(),
              const SizedBox(height: 15),
              // categories
              _mainCategories(),
              const SizedBox(height: 15),
              // Advertisement
              _advertisement(),
              const SizedBox(height: 12),
              // Filters
              _filters(context),
              // const SizedBox(height: 15),
              // // 2nd Category
              // _secondCategory(),
              // const SizedBox(height: 15),
              // // top rated
              // _topRated(),
              // const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }

  Widget _searchBox() {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: ColorConstants.blue50,
        border: Border.all(color: ColorConstants.blue200),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(CupertinoIcons.search, color: ColorConstants.blue700),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                "Search for products",
                style: TextStyle(
                  fontSize: 19,
                  color: ColorConstants.blue700,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              Icons.camera_alt_outlined,
              color: ColorConstants.blue700,
            ),
          ),
          SizedBox(
            width: 15,
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(CupertinoIcons.mic, color: ColorConstants.blue700),
          ),
        ],
      ),
    );
  }

  Widget _mainCategories() {
    return FutureBuilder(
      future: fetchCategoriesFromFirestore(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          var categories = snapshot.data as List<Map<String, dynamic>>;
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: categories.map((category) {
                return ProductsMainCategoryWidget(
                  imagePath: category['categoryImage'],
                  categoryName: category['categoryName'],
                );
              }).toList(),
            ),
          );
        }
      },
    );
  }

  Widget _advertisement() {
    return FutureBuilder(
      future: fetchAdvertisementsFromFirestore(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          var advertisements = snapshot.data as List<Map<String, dynamic>>;
          return Container(
            height: 135,
            child: PageView.builder(
              itemCount: advertisements.length,
              itemBuilder: (context, index) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    height: 135,
                    child: Image.network(
                      advertisements[index]['bannerImage'],
                      fit: BoxFit.fill,
                    ),
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }

  Widget _filters(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        FilterItem(
          label: 'Recently Viewed',
          onPressedAction: () {
            Fluttertoast.showToast(msg: 'Recently Viewed');
          },
          isSelected: true,
        ),
        FilterItem(
            label: 'Categories',
            onPressedAction: () {
              Fluttertoast.showToast(msg: 'Categories');
            }),
        FilterItem(
            label: 'Top Offers',
            onPressedAction: () {
              Fluttertoast.showToast(msg: 'Top Offers');
            }),
        FilterItem(
            label: 'New',
            onPressedAction: () {
              Fluttertoast.showToast(msg: 'New');
            }),
      ],
    );
  }
}

Widget _secondCategory() {
  return Container();
}

Widget _topRated() {
  return Container();
}
