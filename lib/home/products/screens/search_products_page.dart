import 'package:flutter/material.dart';
import 'package:m_soko/common/colors.dart';
import 'package:m_soko/home/products/widgets/search_box_widget.dart';

class SearchProductsPage extends StatefulWidget {
  final List<String> initialHistory;

  const SearchProductsPage({Key? key, required this.initialHistory})
      : super(key: key);

  @override
  _SearchProductsPageState createState() => _SearchProductsPageState();
}

class _SearchProductsPageState extends State<SearchProductsPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstants.bgColour,
        body: Column(
          children: [
            searchBox(context, true),
            searchHistoryTray(context, searchHistoryArray),
          ],
        ),
      ),
    );
  }
}
