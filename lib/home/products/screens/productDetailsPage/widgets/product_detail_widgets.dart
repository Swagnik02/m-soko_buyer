import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:m_soko/common/colors.dart';

Row mobileOtherDetailsRow(String specName, String value, String? valueSUffix) {
  return Row(
    children: [
      Expanded(child: Text(specName)),
      Expanded(
        child: Text(
          '$value$valueSUffix',
          textAlign: TextAlign.center,
          style: const TextStyle(fontWeight: FontWeight.bold),
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
  IconData iconName,
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
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Icon(iconName),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                heading,
                style: const TextStyle(fontSize: 19),
              ),
              Row(
                children: [
                  Text(
                    underlinedSubheading,
                    style: const TextStyle(
                      fontSize: 11,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  Text(
                    nonUnderlinedSubheading,
                    style: const TextStyle(
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
    super.key,
    required this.color,
    required this.controller,
    required this.tabs,
  });

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

class RatingPreview extends StatelessWidget {
  const RatingPreview({
    Key? key,
    required this.totalCount,
    required this.count5Stars,
    required this.count4Stars,
    required this.count3Stars,
    required this.count2Stars,
    required this.count1Stars,
  }) : super(key: key);

  final int totalCount;
  final int count5Stars;
  final int count4Stars;
  final int count3Stars;
  final int count2Stars;
  final int count1Stars;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _ReviewBar(
                label: '5',
                value: count5Stars / totalCount,
                color: Colors.green,
                count: count5Stars,
              ),
              _ReviewBar(
                label: '4',
                value: count4Stars / totalCount,
                color: Colors.green,
                count: count4Stars,
              ),
              _ReviewBar(
                label: '3',
                value: count3Stars / totalCount,
                color: Colors.green,
                count: count3Stars,
              ),
              _ReviewBar(
                label: '2',
                value: count2Stars / totalCount,
                color: Colors.green,
                count: count2Stars,
              ),
              _ReviewBar(
                label: '1',
                value: count1Stars / totalCount,
                color: Colors.green,
                count: count1Stars,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ReviewBar extends StatelessWidget {
  const _ReviewBar({
    Key? key,
    required this.label,
    required this.value,
    required this.count,
    this.color = ColorConstants.green800,
    this.backgroundColor = const Color(0xFFEEEEEE),
    this.labelStyle =
        const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
  }) : super(key: key);

  final String label;
  final TextStyle labelStyle;
  final double value;
  final int count;
  final Color color;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('$label★ ', style: labelStyle.copyWith(color: Colors.black87)),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: SizedBox(
                height: 8,
                child: LinearProgressIndicator(
                  value: value,
                  valueColor: AlwaysStoppedAnimation<Color>(color),
                  backgroundColor: backgroundColor,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 3.0),
            child: Text('$count ',
                style: labelStyle.copyWith(color: Colors.black87)),
          ),
        ],
      ),
    );
  }
}
