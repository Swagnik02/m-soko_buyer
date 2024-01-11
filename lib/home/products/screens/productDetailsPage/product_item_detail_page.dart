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

class ProductItemDetailPage extends StatelessWidget {
  final String pId;
  final ProductModel productModel;

  ProductItemDetailPage({
    super.key,
    required this.pId,
    required this.productModel,
  });
  final ProductItemDetailController controller =
      Get.put(ProductItemDetailController());
  @override
  Widget build(BuildContext context) {
    controller.context = context;
    return WillPopScope(
      onWillPop: controller.onWillPop,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              color: Colors.white,
              onPressed: () => controller.back(),
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
              : _bottomAppBar(context),
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

  Widget _bottomAppBar(BuildContext context) {
    return SizedBox(
      height: 55,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                if (productModel.sellerEmail.toString() != 'null' &&
                    productModel.sellerUid.toString() != 'null') {
                  controller.chatNow(productModel, pId);
                } else {
                  Fluttertoast.showToast(msg: 'SellerID doesnt exists');
                }
              },
              child: Container(
                color: Colors.white,
                child: const Center(
                    child: Text(
                  'Chat Now',
                  style: TextStyle(fontWeight: FontWeight.bold),
                )),
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.amber[500],
              child: const Center(
                  child: Text(
                'Send Inquiry',
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
            ),
          ),
        ],
      ),
    );
  }
}
