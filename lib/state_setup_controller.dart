import 'package:get/get.dart';
import 'package:smartshop/features/shop/controllers/banners_controller.dart';
import 'package:smartshop/features/shop/controllers/product_controller.dart';

void setupController() {
  Get.put(BannersController());
  Get.put(ProductController());
}
