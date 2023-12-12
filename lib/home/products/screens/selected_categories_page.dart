import 'package:flutter/material.dart';
import 'package:m_soko/home/products/products_bloc.dart';

class SelectedCategoryPage extends StatelessWidget {
  final String title;

  SelectedCategoryPage({
    required this.title,
  });

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
            title,
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: FutureBuilder<List<Map<String, dynamic>>>(
          future: futureCheckSelectedCategoryProducts(title),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              List<Map<String, dynamic>> products = snapshot.data!;
              return ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(products[index]['prdItemName']),
                    subtitle: Text(products[index]['prdItemPrice']),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
