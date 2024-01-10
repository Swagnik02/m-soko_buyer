import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:m_soko/common/colors.dart';
import 'package:m_soko/models/product_model.dart';
import 'package:m_soko/navigation/bottomNavigationItems/paymentsPage/payments_details_controller.dart';

class PaymentsDetails extends StatelessWidget {
  final ProductModel productModel;
  final int orderQuantity;
  final double orderDeliveryCharge;
  PaymentsDetails({
    super.key,
    required this.productModel,
    required this.orderQuantity,
    required this.orderDeliveryCharge,
  });
  final PaymentsDetailsController controller =
      Get.put(PaymentsDetailsController());

  @override
  Widget build(BuildContext context) {
    controller.productModel = productModel;
    controller.orderedQuantity = orderQuantity;
    controller.orderDeliveryCharge = orderDeliveryCharge;

    return Scaffold(
        appBar: AppBar(
          title: const Text('Payment Details'),
        ),
        body: GetBuilder<PaymentsDetailsController>(
          builder: (_) => SafeArea(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    _productDetails(),
                    _addressSelection(),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: _billDetails(),
                    ),
                  ],
                ),
                Column(
                  children: [
                    _paymentAdvertisement(),
                    _bottomBar(),
                  ],
                ),
              ],
            ),
          ),
        ));
  }

  Widget _productDetails() {
    return //details
        Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 120,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: SizedBox(
                height: 120,
                width: 120,
                child: Image.network(
                  controller.productThumbnail,
                  // height: 93,
                  // width: 76,
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    controller.productName,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: const TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '$orderQuantity pcs',
                    maxLines: 2,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                        fontSize: 14,
                        color: Colors.green,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Seller: ${controller.sellerName}',
                    maxLines: 2,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _addressSelection() {
    return Container(
      padding: const EdgeInsets.all(16),
      // height: 180,
      color: ColorConstants.blue50,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Deliver to:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              InkWell(
                onTap: () => controller.defaultDialog(),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue, width: 1.5),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text(
                    'Change',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Text(
            controller.orderAddressName,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Text(
              controller.orderAddressDetail,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ),
          TextButton(
              onPressed: () => Fluttertoast.showToast(
                  msg:
                      '${controller.orderAddressName}: ${controller.orderAddressDetail}'),
              child: Text('check address')),
        ],
      ),
    );
  }

  Widget _billDetails() {
    return Container(
      padding: EdgeInsets.all(16),
      color: ColorConstants.bgColour,
      child: Column(
        children: [
          _orderPriceDetailsRow('Price Details:', '', ''),
          _orderPriceDetailsRow('Price(${controller.orderedQuantity}pcs)',
              controller.totalCost.toString(), ''),
          _orderPriceDetailsRow(
              'Quantity', controller.orderedQuantity.toString(), ' pcs'),
          _orderPriceDetailsRow(
              'Discount', controller.totalDiscountAmnt.toString(), ''),
          _orderPriceDetailsRow('Delivery Charges',
              controller.orderDeliveryCharge.toString(), ''),
          const Divider(),
          _orderPriceDetailsRow(
              'Amount Payable', controller.totalPayable.toString(), ''),
        ],
      ),
    );
  }

  Widget _paymentAdvertisement() {
    return Container();
  }

  Widget _bottomBar() {
    return Container();
  }

  Widget _orderPriceDetailsRow(
      String specName, String value, String? valueSUffix) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            specName,
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          Text(
            '$value$valueSUffix',
            // textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          )
        ],
      ),
    );
  }
}
