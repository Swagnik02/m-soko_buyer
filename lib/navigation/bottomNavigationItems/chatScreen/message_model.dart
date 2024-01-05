import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String buyerId;
  final String buyerEmail;
  final String sellerId;
  final String sellerEmail;
  final String message;

  final String imageUrl;
  final Timestamp timestamp;
  final String productId;

  bool isBanner;

  Message({
    this.productId = '',
    required this.buyerId,
    required this.buyerEmail,
    required this.sellerId,
    required this.sellerEmail,
    required this.message,
    this.imageUrl = '',

    //
    required this.timestamp,
    this.isBanner = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'buyerId': buyerId,
      'buyerEmail': buyerEmail,
      'sellerId': sellerId,
      'sellerEmail': sellerEmail,
      'message': message,
      'imageUrl': imageUrl,

      //
      'timestamp': timestamp,
      'isBanner': isBanner,
    };
  }
}
