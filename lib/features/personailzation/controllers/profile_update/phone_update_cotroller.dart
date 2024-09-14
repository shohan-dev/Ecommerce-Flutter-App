import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartshop/common/widget/snackbar/snackbar.dart';
import 'package:smartshop/data/repositories/user/user_repository.dart';
import 'package:smartshop/utils/constants/image_strings.dart';
import 'package:smartshop/utils/network/network_manager.dart';
import 'package:smartshop/utils/popups/full_screen_loader.dart';

class PhoneUpdateCotroller extends GetxController {
  // static PhoneUpdateCotroller get instance => Get.put(PhoneUpdateCotroller());
  static PhoneUpdateCotroller get instance => Get.find();

  final TextEditingController phoneNumber = TextEditingController();
  final GlobalKey<FormState> phoneUpdateFormKey = GlobalKey<FormState>();

  Future<void> updatePhoneNumber() async {
    try {
      TFullScreenLoader.openLoadingDialog("Updating your Phone....",
          TImages.docerLoadingAnimaiton
          );

      // Check internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.closeLoadingDialog();
        TLoaders.errorSnackBar(
          title: "No Internet Connection",
          message: "Please check your internet connection and try again.",
        );
        return;
      }

      // Validate form
      if (!phoneUpdateFormKey.currentState!.validate()) {
        TFullScreenLoader.closeLoadingDialog();
        return;
      }

      phoneNumber.text = phoneNumber.text.trim();

      // Update to firestore
      await UserRepository.instance.singleUpdateUserDetails(
        "phone",
        phoneNumber.text,
      );
      TFullScreenLoader.closeLoadingDialog();
      // after complete remove this screen annd go to profile screen
      Get.back();
    } catch (e) {
      TLoaders.errorSnackBar(
        title: "Unable to update phone number",
        message: e.toString(),
      );
    } finally {
      TFullScreenLoader.closeLoadingDialog();
    }
  }
}
