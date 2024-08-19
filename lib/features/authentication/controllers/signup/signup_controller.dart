import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartshop/common/Privacy/privacy_policy.dart';
import 'package:smartshop/common/Privacy/terms_of_condition.dart';
import 'package:smartshop/common/widget/snackbar/snackbar.dart';
import 'package:smartshop/data/repositories/authentication_repository.dart';
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

      if (!isConnected) return;
      if (!signupFormKey.currentState!.validate()) return;

      if (!privacypolicy.value) {
        TLoaders.warningSnackBar(
            title: "Accept Privacy Policy",
            message: "In order to proceed, you must accept the privacy policy");
        return;

        
      }
      // Register user
      await AuthenticationRepository.instance.registerWithEmailAndPassword(
          email.text.trim(), password.text.trim());


      
     


    } catch (e) {
      TLoaders.errorSnackBar(title: "oh Snap!", message: e.toString());
    } finally {
      TFullScreenLoader.stopLoading();
    }
  }

  void privacyPolicyChanged() {
    Get.to(() => const PrivacyPolicyPage());
  }

  void termsOfServiceChanged() {
    Get.to(() => const TermsConditionsPage());
  }
}
