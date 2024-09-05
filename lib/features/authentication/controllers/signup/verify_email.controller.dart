import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:smartshop/common/widget/snackbar/snackbar.dart';
import 'package:smartshop/common/widget/success_screen.dart';
import 'package:smartshop/data/repositories/autherntication/authentication_repository.dart';
import 'package:smartshop/features/authentication/screen/login/login.dart';
import 'package:smartshop/utils/constants/image_strings.dart';
import 'package:smartshop/utils/constants/text_strings.dart';

class VerifyEmailController extends GetxController {
  static VerifyEmailController get instance => Get.find();

  Timer? _timer;

  @override
  void onInit() {
    sendEmailVerification();
    setTimerForRedirect();
    super.onInit();
  }

  void sendEmailVerification() async {
    try {
      await AuthenticationRepository.instance.sendEmailVerification();
      TLoaders.successSnackBar(
          title: "Email Sent",
          message: "Please check your inbox to verify your email.");
    } on FirebaseAuthException catch (e) {
      TLoaders.errorSnackBar(
          title: "Oh Snap!", message: e.message ?? e.toString());
    }
  }

  // Timer to automatically redirect on email verification
  void setTimerForRedirect() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) async {
      // Reload the current user to get updated email verification status
      await FirebaseAuth.instance.currentUser?.reload();

      // Safely access the currentUser and check if it's null
      final user = FirebaseAuth.instance.currentUser;

      if (user != null && user.emailVerified) {
        timer.cancel(); // Cancel the periodic timer when email is verified
        _timer?.cancel(); // Double-check and cancel the timer instance
        redirectToSuccessScreen(); // Redirect to success screen
      }
    });
  }

  // Redirect to the success screen
  void redirectToSuccessScreen() {
    Get.off(() => SuccessScreenPage(
          title: TTexts.yourAccountCreatedTitle,
          subtitle: TTexts.yourAccountCreatedSubTitle,
          image: TImages.successfullyRegisteredAnimation,
          buttonName: "Continue",
          onPressed: () => AuthenticationRepository.instance.screenRedirect(),
        ));
  }

  @override
  void onClose() {
    _timer?.cancel(); // Cancel the timer when the controller is disposed
    super.onClose();
  }

  // This can be called to manually check email verification
  void checkEmailVerificationStatus() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null && currentUser.emailVerified) {
      redirectToSuccessScreen();
    }
    TLoaders.warningSnackBar(
        title: "Email Not Verified",
        message: "Please verify your email to continue.");
  }

  void signOut() {
    // AuthenticationRepository.instance.signOut();
    FirebaseAuth.instance.signOut();
    Get.offAll(() => const LoginPage());
  }
}
