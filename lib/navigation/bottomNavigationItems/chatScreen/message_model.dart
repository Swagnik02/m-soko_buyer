import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String buyerId;
  final String buyerEmail;
  final String sellerId;
  final String sellerEmail;
  final String message;
  final Timestamp timestamp;

  Message(
      {required this.buyerId,
      required this.buyerEmail,
      required this.sellerId,
      required this.sellerEmail,
      required this.message,
      required this.timestamp});

  Map<String, dynamic> toMap() {
    return {
      'buyerId': buyerId,
      'buyerEmail': buyerEmail,
      'sellerId': sellerId,
      'sellerEmail': sellerEmail,
      'message': message,
      'timestamp': timestamp,
    };
  }
}
