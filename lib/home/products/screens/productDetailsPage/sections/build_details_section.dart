import 'package:flutter/material.dart';
import 'package:m_soko/home/products/screens/productDetailsPage/product_item_detail_controller.dart';
import 'package:m_soko/home/products/screens/productDetailsPage/widgets/product_detail_widgets.dart';
import 'package:m_soko/models/product_model.dart';

Widget buildDetailsSection(
  ProductItemDetailController controller,
  ProductModel productModel,
) {
  return SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 16, bottom: 8.0),
            child: Text(
              'Highlights',
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.w500),
            ),
          ),
          if (productModel.mainCategory == 'Mobiles')
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('RAM | ROM'),
                Text('${productModel.ram} | ${productModel.rom}',
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                const Text('Processor'),
                Text('${productModel.processor}',
                    style: const TextStyle(fontWeight: FontWeight.bold)),

                const Text('Rear Camera'),
                Text('${productModel.rearCamera}',
                    style: const TextStyle(fontWeight: FontWeight.bold)),

                const Text('Front Camera'),
                Text('${productModel.frontCamera}',
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                const Text('Display'),
                Text('${productModel.display}',
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                const Text('Battery'),
                Text('${productModel.battery}',
                    style: const TextStyle(fontWeight: FontWeight.bold)),

                // Other Details

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          'Other Details',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 19,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      mobileOtherDetailsRow(
                          'Network Type', '${productModel.networkType}', ''),
                      mobileOtherDetailsRow(
                          'Sim Type', '${productModel.simType}', ''),
                      mobileOtherDetailsRow('Expandable Storage',
                          '${productModel.isExpandableStorage}', ''),
                      mobileOtherDetailsRow(
                          'Audio Jack', '${productModel.isAudioJack}', ''),
                      mobileOtherDetailsRow('Quick Charging',
                          '${productModel.isQuickCharging}', ''),
                      mobileOtherDetailsRow(
                          'In The Box', '${productModel.inTheBox}', ''),
                    ],
                  ),
                ),

                // Other Details

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          'Seller Details',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 19,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      mobileOtherDetailsRow(
                          'Seller Name', '${productModel.sellerUserName}', ''),
                      mobileOtherDetailsRow(
                          'Seller Email', '${productModel.sellerEmail}', ''),
                      // mobileOtherDetailsRow('Seller UID',
                      //     '${productModel.sellerUid}', ''),
                    ],
                  ),
                ),
              ],
            ),
        ],
      ),
    ),
  );
}
