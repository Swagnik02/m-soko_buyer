import 'package:flutter/material.dart';
import 'package:m_soko/common/colors.dart';
import 'package:m_soko/home/products/products_bloc.dart';
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
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              _topBar(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: advertisement_block(),
              ),
              _mainBody(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _topBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3.0),
            child: Container(
              height: 54,
              alignment: Alignment.center,
              color: Colors.white,
              child: Text('Sort by'),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3.0),
            child: Container(
              height: 54,
              alignment: Alignment.center,
              color: Colors.white,
              child: Text('Filters'),
            ),
          ),
        ),
      ],
    );
  }

  Widget _mainBody() {
    return Expanded(
      child: FutureBuilder<List<Map<String, dynamic>>>(
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
            return ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(products[index]['prdItemName']),
                  subtitle: Text(products[index]['prdItemPrice'].toString()),
                );
              },
            );
          }
        },
      ),
    );
  }
}
