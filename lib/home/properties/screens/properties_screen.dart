import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:m_soko/common/colors.dart';
import 'package:m_soko/common/utils.dart';
import 'package:m_soko/home/properties/property_controller.dart';
import 'package:m_soko/home/properties/widget/properties_screen_widget.dart';
import 'package:m_soko/models/property.dart';
import 'package:m_soko/routes/app_routes.dart';

class PropertiesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PropertyController());
    return Scaffold(
      backgroundColor: ColorConstants.bgColour,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Get.width * 0.03)
                  .copyWith(top: Get.height * 0.02),
              child: Column(
                children: [
                  PropertiesScreenWidget.searchBox(),
                  FutureBuilder(
                    future: controller.fetchHomeImageFromFirebase(),
                    builder: (BuildContext context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        // While data is loading
                        return Utils.customLoadingSpinner();
                      } else if (snapshot.hasError) {
                        // If an error occurs
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else {
                        final data = snapshot.data?.data();
                        return PropertiesScreenWidget.propertiesHomeImage(
                          images: [Image.network(data?['url'])],
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
            PropertiesScreenWidget.filters(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Get.width * 0.03)
                  .copyWith(top: Get.height * 0.02),
              child: FutureBuilder<QuerySnapshot>(
                future: controller.fetchDataFromFirebase(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
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

                      List<PropertyModel> properties = documents.map((e) {
                        Map<String, dynamic> propertyData =
                            e.data() as Map<String, dynamic>;
                        // log(propertyData.toString());
                        return PropertyModel.fromJson(
                            propertyData); // Return the result of fromJson method
                      }).toList();
                      return bottomUi(properties: properties);
                    }
                  }
                  return const Center(
                    child: Text('No Data Available'),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget bottomUi({required List<PropertyModel> properties}) {
    final parseDate = DateFormat.MMMd()
        .format(DateTime.parse(properties[3].postDate.toString()));
    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              PropertiesScreenWidget.propertiesBox(
                image: properties[3].images[0],
                rooms: properties[3].rooms,
                sellingPrice: properties[3].sellingPrice.toString(),
                coveredArea: properties[3].coveredArea.toString(),
                location: properties[3].locality,
                postDate: parseDate,
                onTap: () {
                  Get.toNamed(
                    AppRoutes.propertiesDetailScreen,
                    arguments: properties[3],
                  );
                },
              ),
              SizedBox(width: Get.width * 0.02),
              PropertiesScreenWidget.propertiesBox(
                  image: properties[1].images[0],
                  rooms: properties[1].rooms,
                  sellingPrice: properties[1].sellingPrice.toString(),
                  coveredArea: properties[1].coveredArea.toString(),
                  location: properties[1].locality,
                  postDate: parseDate,
                  onTap: () {
                    Get.toNamed(
                      AppRoutes.propertiesDetailScreen,
                      arguments: properties[1],
                    );
                  }),
            ],
          ),
        ),
        SizedBox(
          height: Get.height * 0.02,
        ),
        Row(
          children: [
            const Text(
              'Hot Deals For You',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const Spacer(),
            InkWell(
              onTap: () => Get.toNamed(AppRoutes.propertiesSeeAllScreen,
                  arguments: properties),
              child: Row(
                children: [
                  const Text(
                    'See All',
                    style: TextStyle(color: Colors.blue, fontSize: 16),
                  ),
                  SizedBox(
                    width: Get.width * 0.02,
                  ),
                  const Icon(Icons.arrow_forward, color: Colors.blue, size: 20),
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          height: Get.height * 0.02,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              PropertiesScreenWidget.propertiesBox(
                image: properties[3].images[0],
                rooms: properties[3].rooms,
                sellingPrice: properties[3].sellingPrice.toString(),
                coveredArea: properties[3].coveredArea.toString(),
                location: properties[3].locality,
                postDate: parseDate,
                onTap: () {
                  Get.toNamed(
                    AppRoutes.propertiesDetailScreen,
                    arguments: properties[3],
                  );
                },
              ),
              SizedBox(width: Get.width * 0.02),
              PropertiesScreenWidget.propertiesBox(
                  image: properties[4].images[0],
                  rooms: properties[4].rooms,
                  sellingPrice: properties[4].sellingPrice.toString(),
                  coveredArea: properties[4].coveredArea.toString(),
                  location: properties[4].locality,
                  postDate: parseDate,
                  onTap: () {
                    Get.toNamed(
                      AppRoutes.propertiesDetailScreen,
                      arguments: properties[4],
                    );
                  }),
            ],
          ),
        ),
        const SizedBox(height: 40),
      ],
    );
  }
}
