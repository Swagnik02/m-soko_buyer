import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:m_soko/common/colors.dart';
import 'package:m_soko/models/product_model.dart';
import 'package:m_soko/navigation/bottomNavigationItems/paymentsPage/payments_details.dart';
import 'package:m_soko/navigation/page_transitions.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final String timeAgo;
  final bool isBuyer;

  const ChatBubble({
    super.key,
    required this.message,
    required this.isBuyer,
    required this.timeAgo,
  });

  @override
  Widget build(BuildContext context) {
    var alignment = (isBuyer) ? Alignment.centerLeft : Alignment.centerRight;

    return Container(
      alignment: alignment,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 2),
        child: Column(
          crossAxisAlignment:
              (isBuyer) ? CrossAxisAlignment.start : CrossAxisAlignment.end,
          mainAxisAlignment:
              (isBuyer) ? MainAxisAlignment.start : MainAxisAlignment.end,
          children: [
            ClipPath(
              clipper: ChatBubbleClipper(isBuyer: isBuyer),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color:
                      isBuyer ? ColorConstants.blue50 : ColorConstants.blue600,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      message,
                      style: TextStyle(
                        fontSize: 16,
                        color: isBuyer ? Colors.black : Colors.white,
                      ),
                    ),
                    Text(
                      timeAgo,
                      style: TextStyle(
                        fontSize: 9,
                        color: isBuyer ? Colors.black : Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatBubbleClipper extends CustomClipper<Path> {
  final double radius;
  final double nipHeight;
  final double nipWidth;
  final double nipRadius;
  final bool isBuyer;

  ChatBubbleClipper({
    this.radius = 15,
    this.nipHeight = 18,
    this.nipWidth = 10,
    this.nipRadius = 5,
    required this.isBuyer,
  });

  @override
  Path getClip(Size size) {
    final path = Path();
    if (isBuyer) {
      path.lineTo(size.width - radius, 0);
      path.arcToPoint(Offset(size.width, radius),
          radius: Radius.circular(radius));
      path.lineTo(size.width, size.height - radius);
      path.arcToPoint(Offset(size.width - radius, size.height),
          radius: Radius.circular(radius));
      path.lineTo(radius + nipWidth, size.height);
      path.arcToPoint(Offset(nipWidth, size.height - radius),
          radius: Radius.circular(radius));
      path.lineTo(nipWidth, nipHeight);
      path.lineTo(nipRadius, nipRadius);
      path.arcToPoint(Offset(nipRadius, 0), radius: Radius.circular(nipRadius));
    } else {
      path.lineTo(size.width - nipRadius, 0);
      path.arcToPoint(Offset(size.width - nipRadius, nipRadius),
          radius: Radius.circular(nipRadius));
      path.lineTo(size.width - nipWidth, nipHeight);
      path.lineTo(size.width - nipWidth, size.height - radius);
      path.arcToPoint(Offset(size.width - nipWidth - radius, size.height),
          radius: Radius.circular(radius));
      path.lineTo(radius, size.height);
      path.arcToPoint(Offset(0, size.height - radius),
          radius: Radius.circular(radius));
      path.lineTo(0, radius);
      path.arcToPoint(Offset(radius, 0), radius: Radius.circular(radius));
    }
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

// chat bubble for banners
class BannerChatBubble extends StatelessWidget {
  final String imageUrl;
  final String message;
  final String timeAgo;
  final bool isBuyer;

  const BannerChatBubble({
    super.key,
    required this.imageUrl,
    required this.message,
    required this.isBuyer,
    required this.timeAgo,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 300,
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: ColorConstants.blue50,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image.network(imageUrl, height: 185, width: 185),
                Text(
                  maxLines: 3,
                  textAlign: TextAlign.center,
                  message,
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                ),
                Text(
                  timeAgo,
                  style: TextStyle(
                    fontSize: 9,
                    color: isBuyer ? Colors.black : Colors.white,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),
        ],
      ),
    );
  }
}

// chat bubble for banners
class ConfirmationChatBubble extends StatelessWidget {
  final String productId;
  final String imageUrl;
  final String message;
  final String timeAgo;
  final int orderQuantity;
  final double orderDeliveryCharge;
  final bool isBuyer;

  const ConfirmationChatBubble({
    super.key,
    required this.productId,
    required this.imageUrl,
    required this.message,
    required this.timeAgo,
    required this.isBuyer,
    required this.orderQuantity,
    required this.orderDeliveryCharge,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 171,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: ColorConstants.blue50,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //details
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Image.network(imageUrl, height: 93, width: 76),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              message,
                              maxLines: 3,
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                  fontSize: 16, color: Colors.black),
                            ),
                            const SizedBox(height: 5),
                            const Text(
                              'Your order will be delivered on July 25th',
                              maxLines: 2,
                              textAlign: TextAlign.left,
                              style:
                                  TextStyle(fontSize: 14, color: Colors.green),
                            ),
                            Text(
                              timeAgo,
                              style: TextStyle(
                                fontSize: 9,
                                color: isBuyer ? Colors.black : Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                //buttons
                SizedBox(
                  height: 40,
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () => Fluttertoast.showToast(msg: 'cancel'),
                          child: Container(
                            height: 40,
                            color: ColorConstants.blue100,
                            child: const Center(
                                child: Text(
                              'Cancel',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )),
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () async {
                            ProductModel? productModel =
                                await collectProductData(productId);
                            if (productModel != null) {
                              Navigator.of(context).push(PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) {
                                  return PaymentsDetails(
                                    productModel: productModel,
                                    orderQuantity: orderQuantity,
                                    orderDeliveryCharge: orderDeliveryCharge,
                                  );
                                },
                                transitionsBuilder:
                                    customTransition(const Offset(0, 0)),
                              ));
                            } else {
                              log('No product data available for $productId');
                            }
                          },
                          child: Container(
                            color: ColorConstants.blue700,
                            child: const Center(
                                child: Text(
                              'Pay Now',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
