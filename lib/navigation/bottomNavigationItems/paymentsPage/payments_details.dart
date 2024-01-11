import 'package:flutter/material.dart';
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

    return WillPopScope(
      onWillPop: controller.onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Payment Details'),
        ),
        body: GetBuilder<PaymentsDetailsController>(
          builder: (_) => SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _productDetails(),
                _addressSelection(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: _billDetails(),
                ),
                _paymentAdvertisement(),
              ],
            ),
          ),
        ),
        bottomNavigationBar: _bottomBar(),
      ),
    );
  }

  Widget _productDetails() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
      child: SizedBox(
        height: 120,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
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
                mainAxisAlignment: MainAxisAlignment.center,
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
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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
            padding: const EdgeInsets.only(right: 0.0),
            child: Text(
              controller.orderAddressDetail,
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  Widget _billDetails() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      color: ColorConstants.bgColour,
      child: Column(
        children: [
          _orderPriceDetailsRow(
            'Price Details:',
            '',
            '',
          ),
          _orderPriceDetailsRow(
            'Price(${controller.orderedQuantity}pcs)',
            double.parse(controller.totalCost.toStringAsFixed(2)).toString(),
            '',
          ),
          _orderPriceDetailsRow(
            'Quantity',
            controller.orderedQuantity.toString(),
            ' pcs',
          ),
          _orderPriceDetailsRow(
            'Discount',
            double.parse(controller.totalDiscountAmnt.toStringAsFixed(2))
                .toString(),
            '',
          ),
          _orderPriceDetailsRow(
            'Delivery Charges',
            double.parse(controller.orderDeliveryCharge.toStringAsFixed(2))
                .toString(),
            '',
          ),
          const Divider(),
          _orderPriceDetailsRow(
            'Amount Payable',
            double.parse(controller.totalPayable.toStringAsFixed(2)).toString(),
            '',
          ),
        ],
      ),
    );
  }

  Widget _paymentAdvertisement() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Image.asset('assets/icons/payment_gateway_tico.png'),
        Image.asset('assets/icons/payment_gateway_mpeso.png'),
        Image.asset('assets/icons/payment_gateway_airtel.png'),
        Image.asset('assets/icons/payment_gateway_cards.png'),
      ],
    );
  }

  Widget _bottomBar() {
    return SizedBox(
      height: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Total Amount',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                ),
                Text(
                  double.parse(controller.totalPayable.toStringAsFixed(2))
                      .toString(),
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () => controller.continuePayment,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(5),
                    color: ColorConstants.yellow400,
                  ),
                  alignment: Alignment.center,
                  height: 60,
                  child: const Text(
                    'Continue',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // widgets
  Widget _orderPriceDetailsRow(
      String specName, String value, String? valueSUffix) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            specName,
            style: const TextStyle(fontWeight: FontWeight.w500),
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
