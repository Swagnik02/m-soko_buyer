import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:m_soko/common/colors.dart';
import 'package:m_soko/common/utils.dart';
import 'package:m_soko/home/properties/property_controller.dart';
import 'package:m_soko/models/property.dart';
import 'package:m_soko/navigation/bottomNavigationItems/propertyMessageScreen/property_message_screen.dart';

class PropertiesScreenWidget {
  static Widget searchBox() {
    return InkWell(
      onTap: () {
        Fluttertoast.showToast(msg: 'Under Construction');
      },
      child: Container(
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

  static Widget filtersForDetailScreen() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _filterItemForDetailScreen(
            label: 'Laundry Service',
            onTap: () {
              Fluttertoast.showToast(msg: 'Recently Viewed');
            },
          ),
          _filterItemForDetailScreen(label: 'Visitor Parking', onTap: () {}),
          _filterItemForDetailScreen(
              label: 'Water Disposal',
              onTap: () {
                Fluttertoast.showToast(msg: 'Top Offers');
              }),
          _filterItemForDetailScreen(
            label: '+23',
            onTap: () {
              Fluttertoast.showToast(msg: 'New');
            },
          ),
        ],
      ),
    );
  }

  static Widget _filterItemForDetailScreen({
    required Function onTap,
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
          color: Colors.grey,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Colors.grey.withOpacity(0.6),
            width: 1.0,
          ),
        ),
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.normal,
          ),
        ),
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

  static Widget propertiesDetailTitleBox({
    required PropertyModel propertyModel,
  }) {
    final convertPostDate =
        Utils.formatPostDate(propertyModel.postDate.toString());
    return FittedBox(
      child: Container(
        width: Get.width,
        padding: EdgeInsets.symmetric(
          horizontal: Get.width * 0.03,
          vertical: Get.height * 0.01,
        ),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "TZS ${propertyModel.sellingPrice} Cr | ${propertyModel.rooms} ${propertyModel.title}",
              style: const TextStyle(
                  fontSize: 26, overflow: TextOverflow.ellipsis),
            ),
            SizedBox(height: Get.height * 0.01),
            Row(
              children: [
                const Icon(Icons.location_on, color: ColorConstants.blue700),
                SizedBox(width: Get.width * 0.01),
                Text(
                  propertyModel.locality,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                )
              ],
            ),
            SizedBox(height: Get.height * 0.008),
            Text(
              'Post on $convertPostDate, By ${propertyModel.postBy}',
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: Get.height * 0.01),
            Text(
              'Rera Id: ${propertyModel.reraId}',
              style: const TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget propertiesDetailContactBox({
    required PropertyModel propertyModel,
  }) {
    return FittedBox(
      child: Container(
        width: Get.width,
        padding: EdgeInsets.symmetric(
          horizontal: Get.width * 0.03,
          vertical: Get.height * 0.01,
        ),
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'AGENT',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.blue.shade700,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  propertyModel.agentName,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
            Utils.customButton(
              title: 'Contact Now',
              onTap: () {
                Get.to(
                  PropertyMessageScreen(
                    receiverEmail: propertyModel.agentEmail,
                    receiverName: propertyModel.agentName,
                    myEmail:
                        FirebaseAuth.instance.currentUser?.email.toString() ??
                            '',
                    myName: FirebaseAuth.instance.currentUser?.displayName
                            .toString() ??
                        '',
                    userType: 'Agents',
                  ),
                );
              },
              size: const Size(160, 60),
            ),
          ],
        ),
      ),
    );
  }

  static Widget propertiesDetailInfoBox(
      {required PropertyModel propertyModel}) {
    final convertPostDate =
        Utils.formatPostDate(propertyModel.postDate.toString());
    return FittedBox(
      child: Container(
        width: Get.width,
        padding: EdgeInsets.symmetric(
          horizontal: Get.width * 0.03,
          vertical: Get.height * 0.01,
        ),
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Utils.titleWithSubTitle(
                firstTitle: 'Covered Area',
                firstSubTitle: "${propertyModel.coveredArea} sqft",
                secondTitle: 'Furnishing',
                secondSubTitle: 'Semi-Furnished'),
            SizedBox(height: Get.height * 0.01),
            Utils.titleWithSubTitle(
                firstTitle: 'Configuration',
                firstSubTitle:
                    "${propertyModel.bedRoom} Bed, ${propertyModel.bathRoom} Bath",
                paddingSecond: EdgeInsets.only(right: Get.width * 0.12),
                secondTitle: 'Status',
                secondSubTitle: propertyModel.listingStatus),
            SizedBox(height: Get.height * 0.01),
            Utils.titleWithSubTitle(
                firstTitle: 'Possession',
                firstSubTitle: convertPostDate,
                secondTitle: 'Car Packing',
                secondSubTitle: '1 Covered'),
          ],
        ),
      ),
    );
  }

  static Widget propertiesDetailBox({required PropertyModel propertyModel}) {
    return FittedBox(
      child: Container(
        width: Get.width,
        padding: EdgeInsets.symmetric(
          horizontal: Get.width * 0.03,
          vertical: Get.height * 0.01,
        ),
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Properties Details',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(height: Get.height * 0.02),
            Utils.titleWithSubTitle(
              firstTitle: 'Transaction',
              secondTitle: 'New Property',
              firstTextStyleTitle:
                  const TextStyle(fontSize: 18, color: Colors.grey),
              secondTextStyleTitle:
                  const TextStyle(fontSize: 14, color: Colors.black),
            ),
            Utils.titleWithSubTitle(
              firstTitle: 'Water Availability',
              secondTitle: "${propertyModel.waterAvailability} Hours",
              firstTextStyleTitle:
                  const TextStyle(fontSize: 18, color: Colors.grey),
              secondTextStyleTitle:
                  const TextStyle(fontSize: 14, color: Colors.black),
            ),
            Utils.titleWithSubTitle(
              firstTitle: 'Status of\nElectricity',
              secondTitle: "NO/Rare Powercut",
              firstTextStyleTitle:
                  const TextStyle(fontSize: 18, color: Colors.grey),
              secondTextStyleTitle:
                  const TextStyle(fontSize: 14, color: Colors.black),
            ),
            Utils.titleWithSubTitle(
              firstTitle: 'Approved by\nbanks',
              secondTitle: propertyModel.bankName,
              firstTextStyleTitle:
                  const TextStyle(fontSize: 18, color: Colors.grey),
              secondTextStyleTitle:
                  const TextStyle(fontSize: 14, color: Colors.black),
            ),
            Utils.titleWithSubTitle(
              firstTitle: 'Project RERA\nID',
              secondTitle: propertyModel.reraId,
              firstTextStyleTitle:
                  const TextStyle(fontSize: 18, color: Colors.grey),
              secondTextStyleTitle:
                  const TextStyle(fontSize: 14, color: Colors.black),
            ),
            Utils.titleWithSubTitle(
              firstTitle: 'Loan Offered by',
              secondTitle: propertyModel.bankName,
              firstTextStyleTitle:
                  const TextStyle(fontSize: 18, color: Colors.grey),
              secondTextStyleTitle:
                  const TextStyle(fontSize: 14, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }

  static Widget propertiesDetailAmenitiesBox(
      {required PropertyModel propertyModel}) {
    return FittedBox(
      child: Container(
        width: Get.width,
        padding: EdgeInsets.symmetric(
          horizontal: Get.width * 0.03,
          vertical: Get.height * 0.01,
        ),
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Amenities',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(height: Get.height * 0.02),
            PropertiesScreenWidget.filtersForDetailScreen(),
          ],
        ),
      ),
    );
  }

  static Widget propertiesDetailDisclaimerBox({
    required PropertyModel propertyModel,
    required PropertyController controller,
  }) {
    return FittedBox(
      child: Container(
        width: Get.width,
        padding: EdgeInsets.symmetric(
          horizontal: Get.width * 0.03,
          vertical: Get.height * 0.01,
        ),
        color: Colors.white,
        child: Obx(
          () => Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Disclaimer',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: Get.height * 0.02),
              RichText(
                text: TextSpan(
                  children: [
                    WidgetSpan(
                      child: Text(
                        propertyModel.disclaimer,
                        maxLines:
                            controller.isExpandedForDisclaimer.value ? 2 : 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    WidgetSpan(
                      child: InkWell(
                        onTap: () {
                          controller.toggleExpandedForDisclaimer();
                        },
                        child: Text(
                          controller.isExpandedForDisclaimer.value
                              ? 'Read more'
                              : 'Read less',
                          style: const TextStyle(color: Colors.blue),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget propertiesDetailPropertyDescriptionBox({
    required PropertyModel propertyModel,
    required PropertyController controller,
  }) {
    return FittedBox(
      child: Container(
        width: Get.width,
        padding: EdgeInsets.symmetric(
          horizontal: Get.width * 0.03,
          vertical: Get.height * 0.01,
        ),
        color: Colors.white,
        child: Obx(
          () => Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Property Description',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: Get.height * 0.02),
              RichText(
                text: TextSpan(
                  children: [
                    WidgetSpan(
                      child: Text(
                        propertyModel.propertyDescription,
                        maxLines:
                            controller.isExpandedForPropertyDescription.value
                                ? 2
                                : 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    WidgetSpan(
                      child: InkWell(
                        onTap: () {
                          controller.toggleExpandedForPropertyDescription();
                        },
                        child: Text(
                          controller.isExpandedForPropertyDescription.value
                              ? 'Read more'
                              : 'Read less',
                          style: const TextStyle(color: Colors.blue),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
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
    required VoidCallback onTap,
    EdgeInsets? margin,
  }) {
    final convertPostDate = Utils.formatPostDate(postDate.toString());
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 200,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
        ),
        margin: margin,
        padding: EdgeInsets.symmetric(
            horizontal: Get.width * 0.014, vertical: Get.height * 0.006),
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
                fit: BoxFit.cover,
              )),
            ),
            const SizedBox(height: 8),
            Text('$rooms Flat', style: const TextStyle(fontSize: 12)),
            const SizedBox(height: 6),
            Text(
              'TZS $sellingPrice Cr | $coveredArea sqft',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 2),
            Text(location,
                style: const TextStyle(
                    fontSize: 12, overflow: TextOverflow.ellipsis)),
            Text(convertPostDate,
                style:
                    const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
