import 'package:get/get.dart';
import 'package:smartshop/features/personailzation/controllers/address/address_controller.dart';
import 'package:smartshop/features/shop/controllers/banners_controller.dart';
import 'package:smartshop/features/shop/controllers/cart/cart_controller.dart';
import 'package:smartshop/features/shop/controllers/product_controller.dart';
import 'package:smartshop/features/shop/controllers/single_checkout/single_checkout_controller.dart';

void setupController() {
  Get.put(BannersController());
  Get.put(ProductController());
  Get.put(SingleCheckoutController());
  Get.put(AddressController());
  Get.put(CartController());
}
