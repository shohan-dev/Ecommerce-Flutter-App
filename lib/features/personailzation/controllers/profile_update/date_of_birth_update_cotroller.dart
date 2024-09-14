import 'package:get/get.dart';
import 'package:smartshop/common/widget/snackbar/snackbar.dart';
import 'package:smartshop/data/repositories/user/user_repository.dart';
import 'package:smartshop/utils/constants/image_strings.dart';
import 'package:smartshop/utils/network/network_manager.dart';
import 'package:smartshop/utils/popups/full_screen_loader.dart';

class DateOfBirthUpdateCotroller extends GetxController {
  static DateOfBirthUpdateCotroller get instance =>
      Get.put(DateOfBirthUpdateCotroller());
  final _dateOfBirth = ''.obs;
  get dateOfBirth => _dateOfBirth.value;
  set dateOfBirth(value) => _dateOfBirth.value = value;

  Future<void> updateDateOfBirth(String dateOfBirth) async {
    this.dateOfBirth = dateOfBirth;
    try {
      TFullScreenLoader.openLoadingDialog(
          "Updating your Date of Birth....", TImages.docerLoadingAnimaiton);

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
      await UserRepository.instance.singleUpdateUserDetails(
        "date_of_birth",
        dateOfBirth,
      );
      Get.back();
    } catch (e) {
      TLoaders.errorSnackBar(
        title: "Unable to update Date of Birth",
        message: e.toString(),
      );
    } finally {
      TFullScreenLoader.closeLoadingDialog();
    }
  }
}