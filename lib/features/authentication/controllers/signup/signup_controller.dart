import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

class SignupController extends GetxController {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final isDarkMode = false.obs;

  @override
  void onInit() {
    super.onInit();
    isDarkMode.value = THelperFunctions.isDarkMode(Get.context!);
  }
}
