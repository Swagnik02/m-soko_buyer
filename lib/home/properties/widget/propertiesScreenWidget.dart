import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:m_soko/common/colors.dart';
import 'package:m_soko/common/utils.dart';
import 'package:m_soko/home/products/widgets/filter_items.dart';

class PropertiesScreenWidget {
  static Widget searchBox() {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: ColorConstants.blue50,
        border: Border.all(color: ColorConstants.blue200),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(CupertinoIcons.search, color: ColorConstants.blue700),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                "Search for products",
                style: TextStyle(
                  fontSize: 19,
                  color: ColorConstants.blue700,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 15,
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(CupertinoIcons.mic, color: ColorConstants.blue700),
          ),
        ],
      ),
    );
  }

  static Widget propertiesHomeImage({required List<Widget> images}) {
    return ImageSlideshow(
      children: images,
      // onPageChanged: (val) => onPageChanged(val),
    );
  }

  static Widget filters() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _filterItem(
            label: 'Recently Viewed',
            onTap: () {
              Fluttertoast.showToast(msg: 'Recently Viewed');
            },
            isSelected: true,
          ),
          _filterItem(label: 'Requested', onTap: () {}),
          _filterItem(
              label: 'Shortlisted',
              onTap: () {
                Fluttertoast.showToast(msg: 'Top Offers');
              }),
          _filterItem(
            label: 'Viewed',
            onTap: () {
              Fluttertoast.showToast(msg: 'New');
            },
            isDisabled: true,
          ),
        ],
      ),
    );
  }

  static Widget _filterItem({
    required Function onTap,
    bool isSelected = false,
    bool isDisabled = false,
    required String label,
  }) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        height: 42,
        alignment: Alignment.center,
        margin: EdgeInsets.only(right: Get.width * 0.02),
        padding: EdgeInsets.symmetric(
            vertical: Get.height * 0.002, horizontal: Get.width * 0.02),
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.blue
              : isDisabled
                  ? Colors.grey.withOpacity(0.2)
                  : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.grey.withOpacity(0.6),
            width: 1.0,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  static Widget propertiesBox({
    required String image,
    required String rooms,
    required String coveredArea,
    required String sellingPrice,
    required String location,
    required String postDate,
    required Function onTap,
    EdgeInsets? margin,
  }) {
    return InkWell(
      onTap: () => onTap(),
      child: Container(
        width: 200,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
        ),
        margin: margin,
        padding: EdgeInsets.symmetric(
            horizontal: Get.width * 0.014, vertical: Get.height * 0.004),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 140,
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: image.isEmpty || image == null
                    ? const AssetImage(
                            'assets/PropertyImage/empty_property_image.png')
                        as ImageProvider
                    : NetworkImage(image),
                fit: BoxFit.fill,
              )),
            ),
            const SizedBox(height: 8),
            Text('$rooms Flat', style: const TextStyle(fontSize: 12)),
            const SizedBox(height: 6),
            Text(
              'TZS $sellingPrice Cr | $coveredArea sqft',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 2),
            Text(location, style: const TextStyle(fontSize: 12,overflow: TextOverflow.ellipsis)),
            Text(Utils.formatPostDate(postDate),
                style:
                    const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
