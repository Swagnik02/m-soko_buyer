class ProductsCategoryModel {
  final String prdItemCategory;
  final String pid;
  final String itemThumbnail;
  final String itemName;
  final String itemSubCategory;
  final double itemMrp;
  final double itemShippingCharge;
  final double itemDiscountPercentage;
  final int itemOrderCount;

  ProductsCategoryModel({
    required this.prdItemCategory,
    required this.pid,
    required this.itemThumbnail,
    required this.itemName,
    required this.itemSubCategory,
    required this.itemMrp,
    required this.itemShippingCharge,
    required this.itemDiscountPercentage,
    required this.itemOrderCount,
  });

  factory ProductsCategoryModel.fromJson(Map<String, dynamic> json) {
    return ProductsCategoryModel(
      prdItemCategory: json['prdItemCategory'],
      pid: json['pid'],
      itemThumbnail: json['itemThumbnail'],
      itemName: json['itemName'],
      itemSubCategory: json['itemSubCategory'],
      itemMrp: (json['itemMrp'] as num).toDouble(),
      itemShippingCharge: (json['itemShippingCharge'] as num).toDouble(),
      itemDiscountPercentage:
          (json['itemDiscountPercentage'] as num).toDouble(),
      itemOrderCount: json['itemOrderCount'],
    );
  }
}
