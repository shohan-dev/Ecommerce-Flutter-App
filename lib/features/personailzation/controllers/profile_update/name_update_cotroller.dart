import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartshop/common/widget/snackbar/snackbar.dart';
import 'package:smartshop/data/repositories/user/user_repository.dart';
import 'package:smartshop/utils/constants/image_strings.dart';
import 'package:smartshop/utils/network/network_manager.dart';
import 'package:smartshop/utils/popups/full_screen_loader.dart';

class NameUpdateController extends GetxController {
  static NameUpdateController get instance => Get.put(NameUpdateController());

  final TextEditingController firstName = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  final GlobalKey<FormState> nameUpdateFormKey = GlobalKey<FormState>();

  Future<void> updateName() async {
    try {
      TFullScreenLoader.openLoadingDialog("Updating your Name....",
          TImages.docerLoadingAnimaiton // Fixed typo here
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
      if (!nameUpdateFormKey.currentState!.validate()) {
        TFullScreenLoader.closeLoadingDialog();
        return;
      }

      firstName.text = firstName.text.trim();
      lastName.text = lastName.text.trim();

      // Update to firestore
      await UserRepository.instance.updateUserDetails(
        firstName.text,
        lastName.text,
      );

      TFullScreenLoader.closeLoadingDialog();
      // after complete remove this screen annd go to profile screen
      Get.back();
    } catch (e) {
      TFullScreenLoader.closeLoadingDialog();
      TLoaders.errorSnackBar(
        title: "Unable to update name",
        message: e.toString(),
      );
    }
  }
}
