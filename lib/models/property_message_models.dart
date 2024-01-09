import 'package:cloud_firestore/cloud_firestore.dart';

class PropertyMessageModel {
  final String buyerId;
  final String buyerEmail;
  final String agentId;
  final String agentEmail;
  final String message;
  final Timestamp timestamp;

  PropertyMessageModel({
    required this.buyerId,
    required this.buyerEmail,
    required this.agentId,
    required this.message,
    required this.agentEmail,
    required this.timestamp,
  });

  factory PropertyMessageModel.fromJson(Map<String, dynamic> json) {
    return PropertyMessageModel(
      buyerId: json['buyerId'] ?? '',
      buyerEmail: json['buyerEmail'] ?? '',
      agentId: json['agentId'] ?? '',
      agentEmail: json['agentEmail'] ?? '',
      message: json['message'] ?? '',
      timestamp: json['timestamp'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'buyerId': buyerId,
      'buyerEmail': buyerEmail,
      'agentId': agentId,
      'agentEmail': agentEmail,
      'message': message,
      'timestamp': timestamp,
    };
  }
}
