import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PhoneUpdateCotroller extends GetxController {
  // static PhoneUpdateCotroller get instance => Get.put(PhoneUpdateCotroller());
  static PhoneUpdateCotroller get instance => Get.find();

  final TextEditingController phoneNumber = TextEditingController();
  final GlobalKey<FormState> phoneUpdateFormKey = GlobalKey<FormState>();

  Future<void> updatePhoneNumber() async {
    try {
      // Validate form
      print(phoneUpdateFormKey);
      if (phoneUpdateFormKey.currentState!.validate()) {
        // Form is valid, handle the update logic here
        print("Phone number is valid and ready for update");
      } else {
        // Form is not valid
        print("not validated");
      }
    } catch (e) {
      // Show error message
      print("Error occurred: $e");
    }
  }
}
