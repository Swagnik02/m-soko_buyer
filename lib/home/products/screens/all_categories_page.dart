import 'package:flutter/material.dart';
import 'package:m_soko/common/colors.dart';
import 'package:m_soko/home/products/products_bloc.dart';
import 'package:m_soko/home/products/widgets/products_main_categories.dart';

class AllCategoriesPage extends StatefulWidget {
  const AllCategoriesPage({super.key});

  @override
  State<AllCategoriesPage> createState() => _AllCategoriesPageState();
}

class _AllCategoriesPageState extends State<AllCategoriesPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.white,
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          // actions: [Icon(Icons.search)],
          title: Text(
            'All Categories',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.center,
                end: Alignment.bottomCenter,
                colors: [Colors.white, Colors.blue],
              ),
            ),
            child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    _mainCategories(),
                    _recentlyViewed(),
                    _specialOffers(),
                  ],
                )),
          ),
        ),
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
          return Container(
            // color: Colors.red,
            height: 400,
            child: GridView.builder(
              primary: false,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                // crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              // scrollDirection: Axis.vertical,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return ProductsMainCategoryWidget(
                  imagePath: categories[index]['categoryImage'],
                  categoryName: categories[index]['categoryName'],
                  index: 1,
                );
              },
            ),
          );
        }
      },
    );
  }

  Widget _recentlyViewed() {
    return Container(
      height: 200,
      width: double.infinity,
      // color: Colors.red,
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recently Viewed',
            style: TextStyle(
              fontSize: 23,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ProductsMainCategoryWidget(
                    imagePath: 'assets/tests/Mobiles.png',
                    categoryName: 'Mobiles',
                    index: 2,
                  ),
                  ProductsMainCategoryWidget(
                    imagePath: 'assets/tests/smartWatch.png',
                    categoryName: 'Smart Watches',
                    index: 2,
                  ),
                  ProductsMainCategoryWidget(
                    imagePath: 'assets/tests/Headphones.png',
                    categoryName: 'Headphones',
                    index: 2,
                  ),
                  ProductsMainCategoryWidget(
                    imagePath: 'assets/tests/Laptops.png',
                    categoryName: 'Laptops',
                    index: 2,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _specialOffers() {
    return Container(
      // color: Colors.red,
      height: 800,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Special Offers',
            style: TextStyle(
              fontSize: 23,
            ),
          ),
          _customGrid(),
        ],
      ),
    );
  }

  Widget _customGrid() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SpecialOfferedCategory(
              prdCategoryImage: 'assets/tests/T-shirts.png',
              prdCategory: 'T-shirts',
              discountPercentage: 70,
            ),
            SpecialOfferedCategory(
              prdCategoryImage: 'assets/tests/T-shirts.png',
              prdCategory: 'T-shirts',
              discountPercentage: 70,
            ),
          ],
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SpecialOfferedCategory(
              prdCategoryImage: 'assets/tests/T-shirts.png',
              prdCategory: 'T-shirts',
              discountPercentage: 70,
            ),
            SpecialOfferedCategory(
              prdCategoryImage: 'assets/tests/T-shirts.png',
              prdCategory: 'T-shirts',
              discountPercentage: 70,
            ),
          ],
        ),
      ],
    );
  }
}
