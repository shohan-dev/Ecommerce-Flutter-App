import 'package:get/get.dart';
import 'package:smartshop/common/widget/snackbar/snackbar.dart';
import 'package:smartshop/data/repositories/user/user_repository.dart';
import 'package:smartshop/utils/constants/image_strings.dart';
import 'package:smartshop/utils/network/network_manager.dart';
import 'package:smartshop/utils/popups/full_screen_loader.dart';

class GenderUpdateCotroller extends GetxController {
  var selectedValue = ''.obs;

  void updateSelectedValue(String value) {
    selectedValue.value = value;
  }

  Future<void> updateGender() async {
    try {
      TFullScreenLoader.openLoadingDialog(
          "Updating your Phone....", TImages.docerLoadingAnimaiton);

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
      await UserRepository.instance
          .singleUpdateUserDetails("gender", selectedValue.value);
      Get.back();
    } catch (e) {
      TLoaders.errorSnackBar(
        title: "Unable to update Gender",
        message: e.toString(),
      );
    } finally {
      TFullScreenLoader.closeLoadingDialog();
    }
  }
}