import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_soko/common/utils.dart';
import 'package:m_soko/home/properties/propertyController.dart';
import 'package:m_soko/home/properties/widget/propertiesScreenWidget.dart';

class PropertiesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PropertyController());
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.03)
                .copyWith(top: Get.height * 0.02),
            child: Column(
              children: [
                PropertiesScreenWidget.searchBox(),
                // SizedBox(height: Get.height * 0.00),
                PropertiesScreenWidget.propertiesHomeImage(
                  images: [
                    Image.asset('assets/PropertyImage/PropertyImage-1.png')
                  ],
                ),
              ],
            ),
          ),
          PropertiesScreenWidget.filters(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.03)
                .copyWith(top: Get.height * 0.02),
            child: Column(
              children: [
                PropertiesScreenWidget.propertiesBox(),
              ],
            ),
          )
          /*            FutureBuilder<QuerySnapshot>(
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

                      // Assuming each document has a field called 'imageUrl' containing image URLs
                      List imageUrls = documents.map((e) => e.data()).toList();

                      // Logging the image URLs fetched from Firestore
                      print('Image URLs: $imageUrls');

                      return Text(
                          'data'); */ /*PropertiesScreenWidget.propertiesBox(
                        images: [
                          */ /* */ /*Image.network(imageUrls)*/ /* */ /*
                        ],
                        onPageChanged: (val) {
                          // Do something when page changes
                        },
                      );*/ /*
                    }
                  }
                  return const Center(
                    child: Text('No Data Available'),
                  );
                },
              )*/
        ],
      ),
    );
  }
}
