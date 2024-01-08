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
  final int messageType; //0 - normal text, 1 - banner, 2 - confirmed/payment

  Message({
    required this.productId,
    required this.buyerId,
    required this.buyerEmail,
    required this.sellerId,
    required this.sellerEmail,
    required this.message,
    this.imageUrl = '',

    //
    required this.timestamp,
    this.messageType = 0,
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
      'messageType': messageType,
      'productId': productId,
    };
  }
}
