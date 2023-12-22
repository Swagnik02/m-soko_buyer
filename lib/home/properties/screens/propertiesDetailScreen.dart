import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_soko/common/colors.dart';
import 'package:m_soko/home/properties/propertyController.dart';
import 'package:m_soko/home/properties/widget/propertiesScreenWidget.dart';
import 'package:m_soko/models/property.dart';
import 'package:page_view_dot_indicator/page_view_dot_indicator.dart';

class PropertiesDetailScreen extends StatelessWidget {
  const PropertiesDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final PropertyModel properties = Get.arguments;
    final controller = Get.find<PropertyController>();
    // log(properties.toString());
    return Scaffold(
      backgroundColor: ColorConstants.bgColour,
      appBar: AppBar(
        backgroundColor: ColorConstants.green800,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: Get.width * 0.04),
            child: const Icon(Icons.search),
          )
        ],
      ),
      body: Column(
        children: [
          CarouselSlider.builder(
            itemCount: properties.images.isNotEmpty ? properties.images.length : 1,
            itemBuilder: (BuildContext context, int index, int realIndex) {
              if (properties.images.isEmpty || properties.images[index] == null || properties.images[index].isEmpty) {
                return Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/PropertyImage/empty_property_image.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              } else {
                return Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(properties.images[index]),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              }
            },
            options: CarouselOptions(
              enableInfiniteScroll: false,
              aspectRatio: 16 / 9,
              onPageChanged: (i, option) => controller.setImageViewIndex(i),
              viewportFraction: 1,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
            ),
          ),
          SizedBox(height: Get.height * 0.01),
          if (properties.images.isNotEmpty)
            PageViewDotIndicator(
              currentItem: controller.propertyImageCurrentIndex,
              count: properties.images.length,
              unselectedColor: Colors.grey,
              selectedColor: ColorConstants.blue200,
              size: const Size(20, 10),
              borderRadius: BorderRadius.circular(6),
              boxShape: BoxShape.rectangle,
            ),
          SizedBox(height: Get.height * 0.02),
          PropertiesScreenWidget.propertiesDetailTitleBox(
            propertyModel: properties,
          ),
          SizedBox(height: Get.height * 0.02),
          PropertiesScreenWidget.propertiesDetailContactBox(
            propertyModel: properties,
          ),
          SizedBox(height: Get.height * 0.02),
          PropertiesScreenWidget.propertiesDetailInfoBox(
            propertyModel: properties,
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: () {},
              child: Container(
                  alignment: Alignment.center,
                  height: Get.height * 0.08,
                  color: Colors.white,
                  child: const Text(
                    'Chat Now',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  )),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () {},
              child: Container(
                alignment: Alignment.center,
                height: Get.height * 0.08,
                color: ColorConstants.yellow400,
                child: const Text(
                  'Call Agent',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
