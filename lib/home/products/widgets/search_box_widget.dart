import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:m_soko/common/colors.dart';
import 'package:m_soko/home/products/screens/search_products_page.dart';
import 'package:m_soko/home/products/screens/search_result_page.dart';

final TextEditingController _searchText = TextEditingController();
Widget searchBox(
  BuildContext context,
  bool isSearchable,
) {
  return Container(
    height: 51,
    decoration: BoxDecoration(
      color: isSearchable ? Colors.white : ColorConstants.blue50,
      border: Border.all(
          color: isSearchable ? Colors.white : ColorConstants.blue200),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: GestureDetector(
              onTap: () {
                String searchKeyword = _searchText.text;
                isSearchable
                    ? Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                SearchResultPage(searchKeyword: searchKeyword)),
                      )
                    : Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SearchProductsPage()),
                      );
              },
              child: Icon(CupertinoIcons.search,
                  color: isSearchable ? Colors.black : ColorConstants.blue700)),
        ),
        Expanded(
          child: isSearchable
              ? TextField(
                  controller: _searchText,
                  decoration: InputDecoration(
                    hintText: 'Search for products',
                    border: InputBorder.none,
                  ),
                )
              : GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SearchProductsPage()),
                    );
                    Fluttertoast.showToast(msg: 'search');
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      "Search for products",
                      style: TextStyle(
                        fontSize: 19,
                        color: isSearchable
                            ? Colors.black
                            : ColorConstants.blue700,
                      ),
                    ),
                  ),
                ),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              Fluttertoast.showToast(msg: 'camera');
            },
            child: Icon(
              Icons.camera_alt_outlined,
              color: isSearchable ? Colors.black : ColorConstants.blue700,
            ),
          ),
        ),
        SizedBox(
          width: isSearchable ? 4 : 12,
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: GestureDetector(
              onTap: () {
                Fluttertoast.showToast(msg: 'voice');
              },
              child: Icon(isSearchable ? Icons.mic : CupertinoIcons.mic,
                  color: isSearchable ? Colors.black : ColorConstants.blue700)),
        ),
      ],
    ),
  );
}
