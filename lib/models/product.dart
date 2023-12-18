// class SelectedItem {
//   String prdItemCategory;
//   String pid;
//   String UID;

//   // Basic infos for thumbnail
//   String itemImage;
//   String itemName;
//   String itemSubCategory;
//   double itemPrice;
//   double itemShippingCharge;
//   double itemDiscountPercentage;
//   int itemOrderCount;

//   // In details
//   String itemImage1;
//   String itemImage2;
//   String itemImage3;

//   // Specs/Highlights
//   // Add more fields as needed

//   // Ratings and reviews
//   // Add the remaining fields here

//   // Constructor
//   SelectedItem({
//     required this.prdItemCategory,
//     required this.pid,
//     required this.UID,
//     required this.itemImage,
//     required this.itemName,
//     required this.itemSubCategory,
//     required this.itemPrice,
//     required this.itemShippingCharge,
//     required this.itemDiscountPercentage,
//     required this.itemOrderCount,
//     required this.itemImage1,
//     required this.itemImage2,
//     required this.itemImage3,
//     // Add parameters for additional fields
//   });

//   // Factory method to create an instance of SelectedItem from a Map
//   factory SelectedItem.fromMap(Map<String, dynamic> map) {
//     return SelectedItem(
//       prdItemCategory: map['prdItemCategory'],
//       pid: map['pid'],
//       UID: map['UID'],
//       itemImage: map['itemImage'],
//       itemName: map['itemName'],
//       itemSubCategory: map['itemSubCategory'],
//       itemPrice: map['itemPrice'],
//       itemShippingCharge: map['itemShippingCharge'],
//       itemDiscountPercentage: map['itemDiscountPercentage'],
//       itemOrderCount: map['itemOrderCount'],
//       itemImage1: map['itemImage1'],
//       itemImage2: map['itemImage2'],
//       itemImage3: map['itemImage3'],
//       // Add mappings for additional fields
//     );
//   }
// }

// Future<List<SelectedItem>> futureCheckSelectedCategoryProducts(
//     String category) async {
//   var querySnapshot =
//       await FirebaseFirestore.instance.collection('product_Items').get();

//   var filteredDocs =
//       querySnapshot.docs.where((doc) => doc['prdItemCategory'] == category);

//   return filteredDocs.map((doc) {
//     return SelectedItem(
//       prdItemCategory: doc['prdItemCategory'],
//       pid: doc['pid'],
//       UID: doc['UID'],
//       itemImage: doc['itemImage'],
//       itemName: doc['itemName'],
//       itemSubCategory: doc['itemSubCategory'],
//       itemPrice: doc['itemPrice'],
//       itemShippingCharge: doc['itemShippingCharge'],
//       itemDiscountPercentage: doc['itemDiscountPercentage'],
//       itemOrderCount: doc['itemOrderCount'],
//       itemImage1: doc['itemImage1'],
//       itemImage2: doc['itemImage2'],
//       itemImage3: doc['itemImage3'],
//       // Add mappings for additional fields
//     );
//   }).toList();
// }
