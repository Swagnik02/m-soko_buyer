import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_soko/common/colors.dart';
import 'package:m_soko/common/utils.dart';
import 'package:m_soko/home/properties/propertyController.dart';
import 'package:m_soko/home/properties/widget/propertiesScreenWidget.dart';
import 'package:m_soko/models/property.dart';
import 'package:m_soko/routes/appRoutes.dart';

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
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: controller.fetchDataFromFirebase(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                  return PropertiesScreenWidget.propertiesBox(
                    margin: EdgeInsets.symmetric(vertical: Get.height * 0.008),
                    image: data.images.isNotEmpty ? data.images[0] : '',
                    rooms: data.rooms,
                    coveredArea: data.coveredArea.toString(),
                    sellingPrice: data.sellingPrice.toString(),
                    location: data.location,
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
      ),
    );
  }
}
