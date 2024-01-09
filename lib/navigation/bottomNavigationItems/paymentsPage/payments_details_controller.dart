import 'package:get/get.dart';
import 'package:m_soko/models/product_model.dart';

class PaymentsDetailsController extends GetxController {
  late ProductModel productModel;

  // products
  late String productName = productModel.itemName.toString();
  late String productThumbnail = productModel.itemThumbnail.toString();
  late double productPrice = productModel.itemMrp ?? 0.0;
  late double productDiscount = productModel.itemDiscountPercentage ?? 0.0;

  // seller
  late String sellerName = productModel.itemName.toString();

  // user
  late String orderAddress = productModel.itemName.toString();

  // order
  late int orderedQuantity = 10;
}
