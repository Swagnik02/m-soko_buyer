import 'package:flutter/material.dart';

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
