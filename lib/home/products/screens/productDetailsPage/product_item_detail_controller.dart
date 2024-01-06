import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
    update(); // Use update() to trigger a rebuild when the tab changes
  }
}
