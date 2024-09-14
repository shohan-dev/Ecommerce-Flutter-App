import 'dart:io';
import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
// ignore: depend_on_referenced_packages
import 'package:image/image.dart' as img;
import 'package:smartshop/common/widget/snackbar/snackbar.dart';
import 'package:smartshop/data/repositories/user/user_repository.dart';
import 'package:smartshop/utils/constants/image_strings.dart';
import 'package:smartshop/utils/network/network_manager.dart';
import 'package:smartshop/utils/popups/full_screen_loader.dart';

class ProfileController extends GetxController {
  // To store the selected image file
  Rx<File?> profileImage = Rx<File?>(null);

  // Singleton pattern for accessing the controller
  static ProfileController get instance {
    if (Get.isRegistered<ProfileController>()) {
      return Get.find<ProfileController>();
    } else {
      return Get.put(ProfileController());
    }
  }

  Future<void> updateProfilePicture() async {
    try {
      final picker = ImagePicker();
      final XFile? result = await picker.pickImage(source: ImageSource.gallery);
      if (result != null) {
        profileImage.value = File(result.path);

        // Compress the image if it's larger than 100 KB
        File? compressedImage =
            await compressImageIfNeeded(profileImage.value!);

        // Show loading dialog
        TFullScreenLoader.openLoadingDialog(
            "Uploading your Photo....", TImages.docerLoadingAnimaiton);

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

        // Ensure to pass the compressed image file to the upload method
        final uploadSuccess = await UserRepository.instance
            .imageUploadUser(compressedImage ?? profileImage.value);
        if (uploadSuccess) {
          TLoaders.successSnackBar(
            title: "Upload Successful",
            message: "Your profile picture has been updated.",
          );
        } else {
          TLoaders.errorSnackBar(
            title: "Upload Error",
            message: "Failed to upload image. Please try again.",
          );
        }
      }
    } catch (e) {
      TLoaders.errorSnackBar(
        title: "Image Upload Error",
        message: "Failed to upload image. Error: ${e.toString()}",
      );
    } finally {
      // Always close the loading dialog
      TFullScreenLoader.closeLoadingDialog();
    }
  }

  Future<File?> compressImageIfNeeded(File file) async {
    // Check the file size
    const int maxSize = 100 * 1024; // 100 KB
    final int fileSize = await file.length();

    if (fileSize > maxSize) {
      // Read the image file
      final Uint8List imageBytes = await file.readAsBytes();
      final img.Image? image = img.decodeImage(imageBytes);

      if (image != null) {
        // Compress the image
        final Uint8List compressedBytes = img.encodeJpg(image, quality: 75);

        // Save the compressed image to a new file
        final File compressedFile = File('${file.path}_compressed.jpg');
        await compressedFile.writeAsBytes(compressedBytes);

        return compressedFile;
      }
    }
    return null; // Return null if no compression is needed
  }
}
