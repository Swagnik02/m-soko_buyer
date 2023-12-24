// // ignore_for_file: sized_box_for_whitespace

// import 'package:flutter/material.dart';
// import 'package:m_soko/common/colors.dart';
// import 'package:m_soko/home/products/products_bloc.dart';
// import 'package:m_soko/home/products/widgets/product_thumbnails.dart';
// import 'package:m_soko/home/products/widgets/products_advertisement.dart';
// import 'package:m_soko/home/products/widgets/sortby_filters_topbar.dart';

// class SelectedCategoryPage extends StatelessWidget {
//   final String title;

//   const SelectedCategoryPage({
//     super.key,
//     required this.title,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: ColorConstants.bgColour,
//         appBar: AppBar(
//           title: Text(
//             title,
//           ),
//         ),
//         body: SingleChildScrollView(
//           scrollDirection: Axis.vertical,
//           physics: const BouncingScrollPhysics(),
//           child: Padding(
//               padding: const EdgeInsets.all(12),
//               child: Column(
//                 children: [
//                   topBar(context),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 16.0),
//                     child: advertisementBlock(),
//                   ),
//                   _mainBody(),
//                 ],
//               )),
//         ),
//       ),
//     );
//   }

//   Widget _mainBody() {
//     return FutureBuilder<List<Map<String, dynamic>>>(
//       future: futureCheckSelectedCategoryProducts(title),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const CircularProgressIndicator();
//         } else if (snapshot.data == null || snapshot.data!.isEmpty) {
//           return const Center(child: Text('No data found'));
//         } else if (snapshot.hasError) {
//           return Text('Error: ${snapshot.error}');
//         } else {
//           List<Map<String, dynamic>> products = snapshot.data!;
//           return Container(
//             // color: Colors.red,
//             height: (products.length / 2) * 700,
//             child: GridView.builder(
//               primary: false,
//               physics: const NeverScrollableScrollPhysics(),
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 childAspectRatio: 0.58,
//                 crossAxisSpacing: 18.0,
//                 mainAxisSpacing: 20.0,
//               ),
//               itemCount: products.length,
//               itemBuilder: (context, index) {
//                 return ProductThumbnail(
//                   itemPid: (products[index]['pid']),
//                   itemThumbnail: (products[index]['itemThumbnail']),
//                   itemSubCategory: (products[index]['itemSubCategory']),
//                   itemName: (products[index]['itemName']),
//                   itemMrp: (products[index]['itemMrp']),
//                   itemShippingCharge:
//                       (products[index]['itemShippingCharge']).toString(),
//                   itemDiscountPercentage: (products[index]
//                       ['itemDiscountPercentage']),
//                   itemOrderCount:
//                       (products[index]['itemOrderCount']).toString(),
//                 );
//               },
//             ),
//           );
//         }
//       },
//     );
//   }
// }
