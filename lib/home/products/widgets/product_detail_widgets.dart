import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Row mobileOtherDetailsRow(String specName, String value, String? valueSUffix) {
  return Row(
    children: [
      Expanded(child: Text(specName)),
      Expanded(
        child: Text(
          '$value$valueSUffix',
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      )
    ],
  );
}

Tab customTab(String iconUrl, String tabName) {
  return Tab(
    child: Container(
      child: Row(
        children: [
          Image.asset(iconUrl),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(tabName),
          ),
        ],
      ),
    ),
  );
}

Padding purchaseDetailsRow(
  IconData iconName, // Change the parameter type to IconData
  String heading,
  String underlinedSubheading,
  String nonUnderlinedSubheading,
) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 5.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Icon(iconName), // Use the passed iconName
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                heading,
                style: TextStyle(fontSize: 19),
              ),
              Row(
                children: [
                  Text(
                    underlinedSubheading,
                    style: TextStyle(
                      fontSize: 11,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  Text(
                    nonUnderlinedSubheading,
                    style: TextStyle(
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            Fluttertoast.showToast(msg: 'Shipping Details');
          },
          child: const Icon(
            Icons.arrow_forward_ios_rounded,
            size: 20,
          ),
        ),
      ],
    ),
  );
}

class CustomTabBar extends StatelessWidget implements PreferredSizeWidget {
  final Color color;
  final TabController controller;
  final List<Tab> tabs;

  const CustomTabBar({
    Key? key,
    required this.color,
    required this.controller,
    required this.tabs,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: TabBar(
        controller: controller,
        tabs: tabs,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(48.0);
}
