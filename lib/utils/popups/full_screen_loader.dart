import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartshop/common/widget/loader/animation_loader.dart';
import 'package:smartshop/utils/helpers/helper_functions.dart';

import '../constants/colors.dart';

class TFullScreenLoader {
  static void openLoadingDialog(String text, String animation) {
    showDialog(
      context:
          Get.overlayContext!, // Use Get.overlayContext for overlay dialogs
      barrierDismissible:
          false, // The dialog can't be dismissed by tapping outside it
      builder: (_) => WillPopScope(
        onWillPop: () async => false, // Disable popping with the back button
        child: Container(
          color: THelperFunctions.isDarkMode(Get.context!)
              ? TColors.dark
              : TColors.white,
          width: double.infinity,
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 250), // Adjust the spacing as needed
              TAnimationLoaderWidget(
                text: text,
                animation: animation,
              ),
              // You can add more widgets here if needed
            ],
          ),
        ),
      ),
    );
  }

  static void stopLoading() {
    Navigator.of(Get.overlayContext!).pop();
  }

  static void closeLoadingDialog() {
    Navigator.of(Get.overlayContext!).pop();
  }
}
