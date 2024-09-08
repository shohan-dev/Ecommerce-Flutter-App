import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartshop/common/widget/snackbar/snackbar.dart';
import 'package:smartshop/utils/constants/image_strings.dart';
import 'package:smartshop/utils/network/network_manager.dart';
import 'package:smartshop/utils/popups/full_screen_loader.dart';

class NameUpdateCotroller extends GetxController {
  static NameUpdateCotroller get instance => Get.put(NameUpdateCotroller());

  final TextEditingController firstName = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  final GlobalKey<FormState> nameUpdateFormKey = GlobalKey<FormState>();

  Future<void> updateName() async {
    try {
      TFullScreenLoader.openLoadingDialog(
          "Updating your Name....", TImages.docerLoadingAnimaiton);
      // check internect connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.closeLoadingDialog();
        return;
      }
      // validate form
      if (!nameUpdateFormKey.currentState!.validate()) {
        TFullScreenLoader.closeLoadingDialog();
        print("form not validated");
        return;
      }

      // Proceed with the update logic
      print("updating name");
      TFullScreenLoader.closeLoadingDialog();
      // Example: await someService.updateName(firstName.text, lastName.text);
    } catch (e) {
      TLoaders.errorSnackBar(
        title: "Unable to update name",
        message: e.toString(),
      );
    }
  }
}
