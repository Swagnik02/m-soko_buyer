import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_soko/models/product_model.dart';
import 'package:m_soko/navigation/bottomNavigationItems/paymentsPage/payments_details_controller.dart';

class PaymentsDetails extends StatelessWidget {
  final ProductModel productModel;
  PaymentsDetails({
    super.key,
    required this.productModel,
  });
  final PaymentsDetailsController controller =
      Get.put(PaymentsDetailsController());

  @override
  Widget build(BuildContext context) {
    controller.productModel = productModel;
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Payment Details'),
          ),
          body: Column(
            children: [
              _productDetails(),
              _addressSelection(),
              _orderDetails(),
              _paymentAdvertisement(),
              _bottomBar(),
            ],
          )),
    );
  }

  Widget _productDetails() {
    return //details
        Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Image.network(controller.productThumbnail,
                height: 93, width: 76),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  controller.productName,
                  maxLines: 3,
                  textAlign: TextAlign.left,
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                ),
                const SizedBox(height: 5),
                const Text(
                  'Your order will be delivered on July 25th',
                  maxLines: 2,
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 14, color: Colors.green),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _addressSelection() {
    return Container();
  }

  Widget _orderDetails() {
    return Container();
  }

  Widget _paymentAdvertisement() {
    return Container();
  }

  Widget _bottomBar() {
    return Container();
  }
}
