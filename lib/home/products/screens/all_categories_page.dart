import 'package:flutter/material.dart';
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
          title: Text(
            'Categories',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [_mainCategories()],
              )),
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
}
