import 'package:flutter/material.dart';
import 'package:m_soko/common/colors.dart';

class MainCategoryPage extends StatelessWidget {
  final String title;
  final String mainCatType;

  MainCategoryPage({
    required this.title,
    required this.mainCatType,
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
        body: Center(
          child: Text('This is the $mainCatType main category page.'),
        ),
      ),
    );
  }
}
