import 'package:cloud_firestore/cloud_firestore.dart';

class PropertyModel {
  final int bathRoom;
  final String agentUid;
  final String category;
  final bool loanAvailable;
  final dynamic
      locationPoint; // You might need to define a custom class for GeoPoint
  final int storeRoom;
  final String agentNumber;
  final String agentName;
  final int sellingPrice;
  final String bankName;
  final String listingStatus;
  final bool qualityCheck;
  final int waterAvailability;
  final List<dynamic> images;
  final int electricityAvailability;
  final String title;
  final DateTime postDate;
  final dynamic
      plotNumberPoint; // You might need to define a custom class for GeoPoint
  final int bedRoom;
  final String disclaimer;
  final String rooms;
  final String postBy;
  final List<String> services;
  final String reraId;
  final String propertyType;
  final int coveredArea;
  final int kitchen;
  final String propertyDescription;
  final int livingRoom;
  final String location;

  PropertyModel({
    required this.bathRoom,
    required this.agentUid,
    required this.category,
    required this.loanAvailable,
    required this.locationPoint,
    required this.storeRoom,
    required this.agentNumber,
    required this.agentName,
    required this.sellingPrice,
    required this.bankName,
    required this.listingStatus,
    required this.qualityCheck,
    required this.waterAvailability,
    required this.images,
    required this.electricityAvailability,
    required this.title,
    required this.postDate,
    required this.plotNumberPoint,
    required this.bedRoom,
    required this.disclaimer,
    required this.rooms,
    required this.postBy,
    required this.services,
    required this.reraId,
    required this.propertyType,
    required this.coveredArea,
    required this.kitchen,
    required this.propertyDescription,
    required this.livingRoom,
    required this.location,
  });

  factory PropertyModel.fromJson(Map<String, dynamic> json) {

    int parsetoInt(dynamic value) {
      if (value is int) {
        return value;
      } else if (value is String) {
        return int.tryParse(value) ?? 0;
      }
      return 0; // Return a default value if neither int nor String
    }

    return PropertyModel(
      bathRoom: parsetoInt(json['Bath Room']),
      agentUid: json['Agent UID'] as String? ?? '',
      category: json['Category'] as String? ?? '',
      loanAvailable: json['Loan Available'] as bool? ?? false,
      locationPoint: json['Location Point'],
      // Assuming this might be a complex type
      storeRoom: parsetoInt(json['Store Room']),
      agentNumber: json['Agent Number'] as String? ?? '',
      agentName: json['Agent Name'] as String? ?? '',
      sellingPrice: parsetoInt(json['Selling Price']),
      bankName: json['Bank Name'] as String? ?? '',
      listingStatus: json['Listing Status'] as String? ?? '',
      qualityCheck: json['Quality Check'] as bool? ?? false,
      waterAvailability: parsetoInt(json['Water Availability']),
      images: json['Images'] as List<dynamic>? ?? [],
      electricityAvailability: parsetoInt(json['Electricity Availability']),
      title: json['Title'] as String? ?? '',
      postDate: json['Post Date'] != null
          ? DateTime.fromMillisecondsSinceEpoch(
              (json['Post Date'] as Timestamp).seconds * 1000)
          : DateTime.now(),
      plotNumberPoint: json['Plot Number Point'],
      // Assuming this might be a complex type
      bedRoom: parsetoInt(json['Bed Room']),
      disclaimer: json['Disclaimer'] as String? ?? '',
      rooms: json['Rooms'] as String? ?? '',
      postBy: json['Post By'] as String? ?? '',
      services: List<String>.from(json['Services'] as List<dynamic>? ?? []),
      reraId: json['Rera ID'] as String? ?? '',
      propertyType: json['Property Type'] as String? ?? '',
      coveredArea: parsetoInt(json['Covered Area']),
      kitchen: parsetoInt(json['Kitchen']),
      propertyDescription: json['Property Description'] as String? ?? '',
      livingRoom: parsetoInt(json['Living Room']),
      location: json['Location'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Bath Room': bathRoom,
      'Agent UID': agentUid,
      'Category': category,
      'Loan Available': loanAvailable,
      'Location Point': locationPoint,
      'Store Room': storeRoom,
      'Agent Number': agentNumber,
      'Agent Name': agentName,
      'Selling Price': sellingPrice,
      'Bank Name': bankName,
      'Listing Status': listingStatus,
      'Quality Check': qualityCheck,
      'Water Availability': waterAvailability,
      'Images': images,
      'Electricity Availability': electricityAvailability,
      'Title': title,
      'Post Date': postDate.toUtc(),
      'Plot Number Point': plotNumberPoint,
      'Bed Room': bedRoom,
      'Disclaimer': disclaimer,
      'Rooms': rooms,
      'Post By': postBy,
      'Services': services,
      'Rera ID': reraId,
      'Property Type': propertyType,
      'Covered Area': coveredArea,
      'Kitchen': kitchen,
      'Property Description': propertyDescription,
      'Living Room': livingRoom,
      'Location': location,
      // Add all other properties here
    };
  }

  factory PropertyModel.fromDocument(DocumentSnapshot snapshot) {
    Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;

    int parsetoInt(dynamic value) {
      if (value is int) {
        return value;
      } else if (value is String) {
        return int.tryParse(value) ?? 0;
      }
      return 0; // Return a default value if neither int nor String
    }

    return PropertyModel(
      bathRoom: parsetoInt(data?['Bath Room']),
      agentUid: data?['Agent UID'] ?? '',
      category: data?['Category'] ?? '',
      loanAvailable: data?['Loan Available'] ?? false,
      locationPoint: data?['Location Point'],
      storeRoom: parsetoInt(data?['Store Room']),
      agentNumber: data?['Agent Number'] ?? '',
      agentName: data?['Agent Name'] ?? '',
      sellingPrice: parsetoInt(data?['Selling Price']),
      bankName: data?['Bank Name'] ?? '',
      listingStatus: data?['Listing Status'] ?? '',
      qualityCheck: data?['Quality Check'] ?? false,
      waterAvailability: parsetoInt(data?['Water Availability']),
      images: List<String>.from(data?['Images'] ?? ''),
      electricityAvailability: parsetoInt(data?['Electricity Availability']),
      title: data?['Title'] ?? '',
      postDate: data?['Post Date'] != null
          ? (data?['Post Date'] as Timestamp).toDate()
          : DateTime.now(),
      plotNumberPoint: data?['Plot Number Point'],
      bedRoom: parsetoInt(data?['Bed Room']),
      disclaimer: data?['Disclaimer'] ?? '',
      rooms: data?['Rooms'] ?? '',
      postBy: data?['Post By'] ?? '',
      services: List<String>.from(data?['Services'] ?? []),
      reraId: data?['Rera ID'] ?? '',
      propertyType: data?['Property Type'] ?? '',
      coveredArea: parsetoInt(data?['Covered Area']),
      kitchen: parsetoInt(data?['Kitchen']),
      propertyDescription: data?['Property Description'] ?? '',
      livingRoom: parsetoInt(data?['Living Room']),
      location: data?['Location'] ?? '',
      // Add all other properties here
    );
  }
}
