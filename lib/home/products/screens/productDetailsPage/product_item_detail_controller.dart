import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_soko/models/product_model.dart';
import 'package:m_soko/navigation/bottomNavigationItems/chatScreen/chat_screen.dart';
import 'package:m_soko/navigation/bottomNavigationItems/chatScreen/chat_service.dart';

class ProductItemDetailController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late BuildContext context;
  late TabController tabController;
  int selectedSectionIndex = 0;
  int selectedImageIndex = 0;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 3, vsync: this);
    tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    selectedSectionIndex = tabController.index;
    update();
  }

  // pop
  void pop() {
    Navigator.of(context).pop();
  }

  // chatWith fuction
  void startChat(ProductModel productModel, String pId) async {
    await ChatService().sendMessage(
      productModel.sellerUid ?? '',
      productModel.sellerEmail ?? '',
      productModel.sellerUserName ?? '',
      'I am interested in ${productModel.itemName}',
      MessageType.banner,
      productModel,
    );

    Get.back();

    Get.off(
      ChatScreen(
        sellerUserEmail: productModel.sellerEmail.toString(),
        sellerUserID: productModel.sellerUid.toString(),
        sellerUserName: productModel.sellerUserName.toString(),
      ),
    );
  }

  void chatNow(ProductModel productModel, String pId) {
    Get.defaultDialog(
      titlePadding: EdgeInsets.all(16),
      title: productModel.itemName ?? 'product',
      titleStyle: TextStyle(fontSize: 20),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              startChat(productModel, pId);
            },
            child: Text('Start'),
          ),
        ],
      ),
    );
  }

  // send enquiry
  void sendEnquiry() {}

  // add to saved
  void bookmarkProduct() {}

  // share product
  void shareProduct() {}

  // allDetails
  void goToAllDetails() {}

  // shipping
  void shippingDetails() {}

  // shipping
  void payemntDetails() {}

  // returns&refunds
  void returnsDetails() {}

  // checkRatings
  void reviewDetails() {}

  void back() {
    Get.back();
    Get.delete<ProductItemDetailController>();
  }

  Future<bool> onWillPop() async {
    back();
    return true;
  }
}
