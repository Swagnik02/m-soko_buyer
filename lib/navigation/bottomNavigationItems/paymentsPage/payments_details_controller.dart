import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_soko/models/product_model.dart';
import 'package:m_soko/models/user_model.dart';

class PaymentsDetailsController extends GetxController {
  late ProductModel productModel;
  late Map<String, dynamic>? userAddress =
      UserDataService().userModel!.addressLines ??
          {'address N/A': 'address N/A'};

  // products
  late String productName = productModel.itemName.toString();
  late String productThumbnail = productModel.itemThumbnail.toString();
  late double productPrice = productModel.itemMrp ?? 0.0;
  late double productDiscountPercentage =
      productModel.itemDiscountPercentage ?? 0.0;

  // cost calculation
  late int orderedQuantity;
  late double orderDeliveryCharge;
  late double totalCost = productPrice * orderedQuantity;
  late double totalDiscountAmnt = totalCost * (productDiscountPercentage / 100);

  late double totalPayable =
      totalCost - totalDiscountAmnt + orderDeliveryCharge;

  // seller
  late String sellerName = productModel.sellerUserName.toString();

  // user
  late String orderAddressName = '';
  late String orderAddressDetail = '';

  // order

  // Function to update selected address

  @override
  void onInit() {
    super.onInit();
    orderAddressName = userAddress!.entries.first.key.toString();
    orderAddressDetail = userAddress!.entries.first.value.toString();
  }

  void updateSelectedAddress(String key, String address) {
    orderAddressName = key;
    orderAddressDetail = address;
    update();
  }

  void defaultDialog() {
    Get.defaultDialog(
      title: "Select Address",
      content: _changeAddrressDialogue(),
    );
  }

  Future<bool> onWillPop() async {
    Get.back();
    Get.delete<PaymentsDetailsController>();
    return true;
  }

  void continuePayment() {}
  //

  //

  // Change Addrress Dialogue
  Widget _changeAddrressDialogue() {
    return GetBuilder<PaymentsDetailsController>(builder: (controller) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: userAddress?.keys.map(
              (String key) {
                String address = userAddress![key].toString();

                return InkWell(
                  onTap: () {
                    controller.updateSelectedAddress(key, address);
                    Get.back();
                  },
                  child: Container(
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color:
                            key == orderAddressName ? Colors.blue : Colors.grey,
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          key,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          address,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ).toList() ??
            [],
      );
    });
  }
}
