import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_soko/models/product_model.dart';
import 'package:m_soko/navigation/bottomNavigationItems/chatScreen/chat_service.dart';

class ProductItemDetailController extends GetxController
    with GetSingleTickerProviderStateMixin {
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

  // chatWith fuction
  void startChat(ProductModel productModel, String pId) async {
    await ChatService().sendMessage(
      productModel.sellerUid ?? '',
      productModel.sellerEmail ?? '',
      productModel.sellerUserName ?? '',
      'I am interested in ${productModel.itemName}',
      productModel.itemThumbnail,
      true,
      pId,
    );
  }
}
