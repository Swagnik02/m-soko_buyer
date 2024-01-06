import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:m_soko/common/colors.dart';
import 'package:m_soko/home/products/screens/productDetailsPage/product_item_detail_controller.dart';
import 'package:m_soko/home/products/screens/productDetailsPage/sections/build_details_section.dart';
import 'package:m_soko/home/products/screens/productDetailsPage/sections/build_overview_section.dart';
import 'package:m_soko/home/products/screens/productDetailsPage/sections/build_similar_section.dart';
import 'package:m_soko/home/products/screens/productDetailsPage/widgets/product_detail_widgets.dart';
import 'package:m_soko/models/product_model.dart';
import 'package:m_soko/navigation/bottomNavigationItems/chatScreen/chat_screen.dart';

class ProductItemDetailPage extends StatelessWidget {
  final String pId;
  final ProductModel productModel;

  const ProductItemDetailPage({
    super.key,
    required this.pId,
    required this.productModel,
  });

  @override
  Widget build(BuildContext context) {
    final ProductItemDetailController controller =
        Get.put(ProductItemDetailController());
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: Colors.white,
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          backgroundColor: ColorConstants.blue700,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(48.0),
            child: CustomTabBar(
              color: Colors.white,
              controller: controller.tabController,
              tabs: [
                customTab('assets/icons/overview_icon.png', 'Overview'),
                customTab('assets/icons/details_icon.png', 'Details'),
                customTab('assets/icons/similar_icon.png', 'Similar'),
              ],
            ),
          ),
        ),
        body: GetBuilder<ProductItemDetailController>(
          builder: (_) => TabBarView(
            controller: controller.tabController,
            children: [
              _buildSectionBody(controller, 0),
              _buildSectionBody(controller, 1),
              _buildSectionBody(controller, 2),
            ],
          ),
        ),
        bottomNavigationBar: controller.selectedSectionIndex == 2
            ? null
            : BottomAppBar(
                elevation: 0,
                clipBehavior: Clip.antiAlias,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          if (productModel.sellerEmail.toString() != 'null' &&
                              productModel.sellerUid.toString() != 'null') {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text(
                                        productModel.itemName ?? 'product'),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('Cancel'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          controller.startChat(
                                              productModel, pId);

                                          Navigator.of(context).pop();

                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => ChatScreen(
                                                sellerUserEmail: productModel
                                                    .sellerEmail
                                                    .toString(),
                                                sellerUserID: productModel
                                                    .sellerUid
                                                    .toString(),
                                                sellerUserName: productModel
                                                    .sellerUserName
                                                    .toString(),
                                              ),
                                            ),
                                          );
                                        },
                                        child: Text('Start'),
                                      ),
                                    ],
                                  );
                                });
                          } else {
                            Fluttertoast.showToast(
                                msg: 'SellerID doesnt exists');
                          }
                        },
                        child: Container(
                          color: Colors.white,
                          child: const Center(child: Text('Chat Now')),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        color: Colors.amber[500],
                        child: const Center(child: Text('Send Inquiry')),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  Widget _buildSectionBody(ProductItemDetailController controller, int index) {
    switch (index) {
      case 0:
        return buildOverviewSection(controller, productModel);
      case 1:
        return buildDetailsSection(controller, productModel);
      case 2:
        return buildSimilarSection(controller, productModel);
      default:
        return Container();
    }
  }
}
