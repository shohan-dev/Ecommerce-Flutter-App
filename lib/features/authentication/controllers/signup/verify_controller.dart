import 'package:get/get.dart';
import 'package:t_store/common/widget/success_screen.dart';
import 'package:t_store/features/authentication/screen/login/login.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/constants/text_strings.dart';

class VerifyPageController extends GetxController {
  static VerifyPageController get instance => Get.put(VerifyPageController());

  void closeActionButton() {
    Get.off(() => const LoginPage());
  }

  void continueButton() {
    Get.off(() => const SuccessScreenPage(
          title: TTexts.yourAccountCreatedTitle,
          subtitle: TTexts.yourAccountCreatedSubTitle,
          image: TImages.staticSuccessIllustration,
          buttonName: "Continue",
        ));
  }

  void resendEmailActionButton() {
    Get.off(() => const SuccessScreenPage(
          title: "",
          subtitle: "",
          image: TImages.verifyIllustration,
          buttonName: "Successful",
        ));
  }
}
