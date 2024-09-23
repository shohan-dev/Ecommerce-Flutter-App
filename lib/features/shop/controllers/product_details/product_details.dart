import 'package:get/get.dart';

class ProductDetailsController extends GetxController {
  static ProductDetailsController get instance => Get.find();
  var selectedColor = "".obs;
  var selectedSize = "".obs;
}
