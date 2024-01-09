import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_soko/common/colors.dart';
import 'package:m_soko/common/utils.dart';
import 'package:m_soko/home/properties/property_controller.dart';
import 'package:m_soko/home/properties/widget/properties_screen_widget.dart';
import 'package:m_soko/models/property.dart';
import 'package:m_soko/routes/app_routes.dart';

class PropertySeeAllScreen extends StatelessWidget {
  const PropertySeeAllScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PropertyController>();
    return Scaffold(
      backgroundColor: ColorConstants.bgColour,
      appBar: AppBar(
        backgroundColor: ColorConstants.green800,
        iconTheme: const IconThemeData(color: Colors.white),
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 18),
        title: const Text('See All'),
        actions: [
          InkWell(
            onTap: () {
              showModalBottomSheet(
                constraints: BoxConstraints(maxHeight: Get.height * 0.4),
                context: context,
                builder: (_) {
                  return _buildSortSection(controller);
                },
              );
            },
            child: const Row(
              children: [
                Icon(Icons.sort),
                SizedBox(width: 12),
                Text(
                  'Sort',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                SizedBox(width: 12),
              ],
            ),
          ),
        ],
      ),
      body: GetBuilder<PropertyController>(builder: (_) {
        return FutureBuilder<QuerySnapshot>(
          future: controller.fetchDataFromFirebase(
            sortOption: controller.selectedSortOption,
          ),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // While data is loading
              return Utils.customLoadingSpinner();
            } else if (snapshot.hasError) {
              // If an error occurs
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else {
              if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                List<DocumentSnapshot> documents = snapshot.data!.docs;
                return GridView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisExtent: 260,
                    crossAxisSpacing: 20,
                  ),
                  itemCount: documents.length,
                  itemBuilder: (context, i) {
                    final PropertyModel data =
                        PropertyModel.fromDocument(documents[i]);
                    log(data.locality.toString());
                    return PropertiesScreenWidget.propertiesBox(
                      margin:
                          EdgeInsets.symmetric(vertical: Get.height * 0.008),
                      image: data.images.isNotEmpty ? data.images[0] : '',
                      rooms: data.rooms,
                      coveredArea: data.coveredArea.toString(),
                      sellingPrice: data.sellingPrice.toString(),
                      location: data.locality,
                      postDate: data.postDate.toString(),
                      onTap: () {
                        Get.toNamed(AppRoutes.propertiesDetailScreen,
                            arguments: data);
                      },
                    );
                  },
                );
              }
            }
            return const Center(
              child: Text('No Data Available'),
            );
          },
        );
      }),
    );
  }

  Widget _buildSortSection(PropertyController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 27, vertical: 23),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            children: [
              const Spacer(),
              const Text(
                'Sort by',
                style: TextStyle(fontSize: 23),
              ),
              const Spacer(),
              InkWell(
                onTap: () => Get.back(),
                child: const Icon(Icons.close),
              ),
            ],
          ),
          const SizedBox(height: 40),
          Utils.customButton(
            backGroundColor: ColorConstants.green300.withOpacity(0.8),
            isIcon: false,
            size: Size(Get.width, 52),
            onTap: () {
              controller.setSortValue('highToLow');
              Get.back();
            },
            title: 'Price: High to Low',
            isSelected: controller.selectedSortOption == 'highToLow',
          ),
          const SizedBox(height: 10),
          Utils.customButton(
            isIcon: false,
            backGroundColor: ColorConstants.green300.withOpacity(0.8),
            size: Size(Get.width, 52),
            onTap: () {
              controller.setSortValue('lowToHigh');
              Get.back();
            },
            title: 'Price: Low to High',
            isSelected: controller.selectedSortOption == 'lowToHigh',
          ),
          const SizedBox(height: 18),
          InkWell(
            onTap: () {
              controller.setSortValue('');
              Get.back();
            },
            child: Text(
              'Reset',
              style: TextStyle(
                color: ColorConstants.green300.withOpacity(0.8),
                fontSize: 16,
              ),
            ),
          )
        ],
      ),
    );
  }
}
