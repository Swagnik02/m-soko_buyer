import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_soko/common/colors.dart';
import 'package:m_soko/navigation/bottomNavigationItems/paymentsPage/payments_page_controller.dart';

class PaymentsPage extends StatelessWidget {
  const PaymentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final PaymentsPageController controller = Get.put(PaymentsPageController());
    return WillPopScope(
      onWillPop: controller.onWillPop,
      child: Scaffold(
        body: GetBuilder<PaymentsPageController>(
          builder: (_) => SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 20.0),
              child: Column(
                children: [
                  _topBody(controller),
                  _mainBodyContainer(controller),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _topBody(PaymentsPageController controller) {
    return const Column(
      children: [
        // safety icon
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            children: [
              Text(
                'Pay with Sokoni',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Icon(
                  Icons.security_rounded,
                  size: 35,
                ),
              )
            ],
          ),
        ),

        // sokoni
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "Sokoni's Secure Payment System: Ensuring Your Transactions are Protected",
            style: TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }

  Widget _mainBodyContainer(PaymentsPageController controller) {
    return Material(
      elevation: 5,
      child: Container(
        // height: 390,
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: ColorConstants.bgColour),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _paymentContactDetails(controller),
            _payNowButton(controller),
          ],
        ),
      ),
    );
  }

  Widget _paymentContactDetails(PaymentsPageController controller) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // TextField for country code
              Expanded(
                child: _customTextField(
                  controller.countryCodeController,
                  'Country Code',
                ),
              ),
              const SizedBox(width: 8.0),

              // TextField for number
              Expanded(
                flex: 4,
                child: _customTextField(
                  controller.mobileNumberController,
                  'Seller mobile number',
                ),
              ),
              const SizedBox(width: 8.0),

              // IconButton for contacts
              IconButton(
                icon: const Icon(Icons.contacts),
                onPressed: () {},
              ),
            ],
          ),
          // TextField for Product name
          _customTextField(controller.productNameController, 'Product name'),

          // TextField for Amount
          _customTextField(controller.amountController, 'Amount'),
        ],
      ),
    );
  }

// Pay Now Button
  Widget _payNowButton(controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 80),
      child: InkWell(
        onTap: () => controller.payNow(),
        child: Container(
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: ColorConstants.skyBlue,
          ),
          alignment: Alignment.center,
          width: double.infinity,
          child: const Text(
            'Pay Now',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Widget _customTextField(
    TextEditingController textEditingController,
    String hintText,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black45),
          borderRadius: BorderRadius.circular(5),
        ),
        width: double.infinity,
        child: TextField(
          style: const TextStyle(fontSize: 18),
          controller: textEditingController,
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(left: 10),
            border: InputBorder.none,
            hintText: hintText,
          ),
        ),
      ),
    );
  }
}
