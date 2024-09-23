import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:smartshop/common/widget/snackbar/snackbar.dart';
import 'package:smartshop/common/widget/success_screen.dart';
import 'package:smartshop/features/authentication/screen/login/login.dart';
import 'package:smartshop/utils/constants/image_strings.dart';
import 'package:smartshop/utils/constants/text_strings.dart';
import 'package:smartshop/utils/network/network_manager.dart';
import 'package:smartshop/utils/popups/full_screen_loader.dart';

class ForgetPasswordController extends GetxController {
  static ForgetPasswordController get instance =>
      Get.put(ForgetPasswordController());

  final TextEditingController email = TextEditingController();

  final GlobalKey<FormState> forgetPasswordFormKey = GlobalKey<FormState>();

  Future<void> sendForgetPassword() async {
    try {
      TFullScreenLoader.openLoadingDialog(
        "Reseting Password....", TImages.docerLoadingAnimaiton);
          
      // check internect connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.closeLoadingDialog();
        return;
      }
      // validate form
      if (!forgetPasswordFormKey.currentState!.validate()) {
        TFullScreenLoader.closeLoadingDialog();
        return;
      }

      await FirebaseAuth.instance.sendPasswordResetEmail(email: email.text);

      // send forget password
      Get.off(() => SuccessScreenPage(
            buttonName: TTexts.done,
            title: TTexts.changeYourPasswordTitle,
            subtitle: TTexts.changeYourPasswordSubTitle,
            image: TImages.deliveredEmailIllustration,
            isLotti: false,
            isSecondButton: true,
            onSecondButtonPressed: () async {
              await FirebaseAuth.instance
                  .sendPasswordResetEmail(email: email.text); // resend email
            },
            onPressed: () {
              Get.offAll(() => const LoginPage());
            },
          ));
    } catch (e) {
      TLoaders.errorSnackBar(
        title: "unable to send forget password",
        message: e.toString(),
      );
    }
  }


}
