import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartshop/common/Privacy/privacy_policy.dart';
import 'package:smartshop/common/Privacy/terms_of_condition.dart';
import 'package:smartshop/common/widget/snackbar/snackbar.dart';
import 'package:smartshop/data/repositories/autherntication/authentication_repository.dart';
import 'package:smartshop/data/repositories/user/user_repository.dart';
import 'package:smartshop/features/authentication/models/user_model.dart';
import 'package:smartshop/features/authentication/screen/signup/verify_email.dart';
import 'package:smartshop/utils/constants/image_strings.dart';
import 'package:smartshop/utils/network/network_manager.dart';
import 'package:smartshop/utils/popups/full_screen_loader.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  // Variables
  final hidepassword = true.obs;
  final privacypolicy = false.obs;
  final email = TextEditingController();
  final password = TextEditingController();
  final username = TextEditingController();
  final phone = TextEditingController();
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  // Methods
  Future<void> signup() async {
    try {
      TFullScreenLoader.openLoadingDialog(
          "We are processing your information", TImages.docerLoadingAnimaiton);

      final isConnected = await NetworkManager.instance.isConnected();

      if (!isConnected) {
        TFullScreenLoader.closeLoadingDialog(); // Close loader if no network
        return;
      }
      if (!signupFormKey.currentState!.validate()) {
        TFullScreenLoader
            .closeLoadingDialog(); // Close loader if form is not valid
        return;
      }

      if (!privacypolicy.value) {
        TFullScreenLoader
            .closeLoadingDialog(); // Close loader if privacy policy is not accepted
        TLoaders.warningSnackBar(
            title: "Accept Privacy Policy",
            message: "In order to proceed, you must accept the privacy policy");
        return;
      }

      // Register user
      await AuthenticationRepository.instance.registerWithEmailAndPassword(
          email.text.trim(), password.text.trim());

      // Save user data
      final newUser = UserModel(
        email: email.text.trim(),
        username: username.text.trim(),
        phone: phone.text.trim(),
        firstName: firstName.text.trim(),
        lastName: lastName.text.trim(),
      );
      // Send the data to Firebase Firestore
      final userRepository = Get.put(UserRepository());
      await userRepository.saveUserRecord(newUser);

      // Close loader after saving data
      TFullScreenLoader.closeLoadingDialog();

      // Navigate to the Verify Email screen
      Get.to(() => const VerifyEmailScreen());
    } catch (e) {
      TFullScreenLoader.closeLoadingDialog(); // Close loader in case of error
      TLoaders.errorSnackBar(title: "Oh Snap!", message: e.toString());
    }
  }

  void privacyPolicyChanged() {
    Get.to(() => const PrivacyPolicyPage());
  }

  void termsOfServiceChanged() {
    Get.to(() => const TermsConditionsPage());
  }
}
