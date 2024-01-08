import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pannable_rating_bar/flutter_pannable_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:m_soko/common/colors.dart';
import 'package:m_soko/common/utils.dart';
import 'package:m_soko/home/products/screens/productDetailsPage/product_item_detail_controller.dart';
import 'package:m_soko/home/products/screens/productDetailsPage/widgets/product_detail_widgets.dart';
import 'package:m_soko/models/product_model.dart';

Widget buildOverviewSection(
  ProductItemDetailController controller,
  ProductModel productModel,
) {
  Map<String, String>? photos = productModel.itemImages;
  List<Widget> imageWidgets = [];

  if (photos != null) {
    photos.forEach((imageKey, imageUrl) {
      imageWidgets.add(Image.network(
        imageUrl,
        fit: BoxFit.cover,
      ));
    });
  }

  return SingleChildScrollView(
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Top Row with Discount Percentage and Share/Bookmark buttons
              Container(
                padding: const EdgeInsets.only(top: 5, left: 12, right: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // discount tag
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: ColorConstants.green50,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        "${productModel.itemDiscountPercentage?.toInt()}% off",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: ColorConstants.green900,
                        ),
                      ),
                    ),
                    // ShareButton and bookmark button
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: InkWell(
                              onTap: () {
                                // Handle share button click
                              },
                              child: const Icon(
                                Icons.share_outlined,
                                size: 18,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: InkWell(
                              onTap: () {
                                // Handle bookmark button click
                              },
                              child: const Icon(
                                Icons.bookmark_border_rounded,
                                // size: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Large Image Container using PageView
              Container(
                height: 280,
                // margin: EdgeInsets.symmetric(vertical: 8.0),
                child: PageView.builder(
                  itemCount: photos != null ? photos.length : 0,
                  onPageChanged: (index) {
                    // setState(() {
                    //   selectedImageIndex = index;
                    // });
                  },
                  itemBuilder: (context, index) {
                    String imageKey = photos!.keys.elementAt(index);
                    return Image.network(
                      photos[imageKey]!,
                      fit: BoxFit.fitHeight,
                    );
                  },
                ),
              ),
              // Image Timeline
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                height: 60.0,
                child: ListView.builder(
                  primary: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: photos != null ? photos.length : 0,
                  itemBuilder: (context, index) {
                    String imageKey = photos!.keys.elementAt(index);
                    return GestureDetector(
                      onTap: () {
                        // Fluttertoast.showToast(msg: index.toString());

                        // setState(() {
                        //   selectedImageIndex = index;
                        // });
                      },
                      child: Container(
                        width: 60.0,
                        margin: const EdgeInsets.symmetric(horizontal: 4.0),
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 3,
                            color: controller.selectedImageIndex == index
                                ? ColorConstants.yellow200
                                : Colors.transparent,
                          ),
                        ),
                        child: Image.network(
                          photos[imageKey]!,
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Price Tag, Min and Max Order, Product Name (Remaining details)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                // color: Colors.grey[200],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${GlobalUtil.currencySymbol}${productModel.itemMrp}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.,
                      children: [
                        Text(
                          "Min Order: ${productModel.itemOrderCount} pieces",
                          style: const TextStyle(
                            fontSize: 13.0,
                          ),
                        ),
                        const SizedBox(width: 30),
                        Text(
                          "< ${productModel.itemOrderCount} pieces",
                          style: const TextStyle(
                            fontSize: 13.0,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      productModel.itemName ?? '',
                      style: const TextStyle(
                        fontSize: 14.0,
                      ),
                    ),

                    // ordercount

                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: RichText(
                        text: TextSpan(
                          text:
                              '${productModel.itemOrderCount} orders | See Store Reviews',
                          style: const TextStyle(
                            color: Colors.black45,
                            fontSize: 14,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Fluttertoast.showToast(msg: 'ratingPage');
                            },
                        ),
                      ),
                    ),

                    // Ratings
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: PannableRatingBar(
                        rate: productModel.itemAvgRating ?? 0,
                        items: List.generate(
                            5,
                            (index) => const RatingWidget(
                                  selectedColor: Color(0xFFFFCE31),
                                  unSelectedColor: Colors.grey,
                                  child: Icon(
                                    Icons.star,
                                    size: 20,
                                  ),
                                )),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // All Details Button
        GestureDetector(
          onTap: () {
            controller.tabController.animateTo(1);
          },
          child: Container(
            padding: const EdgeInsets.all(16),
            width: double.infinity,
            height: 56.1,
            color: ColorConstants.blue50,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('All Details'),
                Icon(Icons.arrow_forward_ios_rounded)
              ],
            ),
          ),
        ),

        // Purchase Details
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Purchase Details',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 19,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Column(
                  children: [
                    purchaseDetailsRow(
                      Icons.local_shipping_outlined,
                      'Shipping',
                      'Contact supplier',
                      ' to negotiate shipping.',
                    ),
                    purchaseDetailsRow(
                      Icons.payment_rounded,
                      'Payment',
                      '',
                      'Enjoy encrypted and secure payments.',
                    ),
                    purchaseDetailsRow(
                      CupertinoIcons.arrow_uturn_left,
                      'Returns & Refunds',
                      '',
                      'Eligible for returns & refunds.',
                    ),
                  ],
                ),
              )
            ],
          ),
        ),

        // Ratings & Reviews
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Ratings & Reviews',
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 19,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    GestureDetector(
                      child: Text('View Reviews',
                          style: TextStyle(color: Colors.blue, fontSize: 14)),
                      onTap: () {},
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  children: [
                    // left side
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        // color: Colors.red,
                        child: Column(
                          children: [
                            Text(
                              '${productModel.itemRatingGrade}',
                              style: TextStyle(
                                  color: Colors.green[700],
                                  // color: Color(0xFF2DA50C),
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold),
                            ),
                            PannableRatingBar(
                              rate: productModel.itemAvgRating ?? 0,
                              items: List.generate(
                                5,
                                (index) => const RatingWidget(
                                  selectedColor: Color(0xFFFFCE31),
                                  unSelectedColor: Colors.grey,
                                  child: Icon(
                                    Icons.star,
                                    size: 26,
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              '${productModel.itemTotalRatingCount} ratings \nand \n${productModel.itemTotalReviewCount} Reviews',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 11,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),

                    // divider

                    const VerticalDivider(
                      color: Colors.black,
                      thickness: 10.0,
                      width: 10.0,
                    ),
                    // right side
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        // color: Colors.yellow,
                        child: Column(
                          children: [
                            RatingPreview(
                              totalCount: 10,
                              count5Stars: 2,
                              count4Stars: 1,
                              count3Stars: 3,
                              count2Stars: 2,
                              count1Stars: 2,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    ),
  );
}
