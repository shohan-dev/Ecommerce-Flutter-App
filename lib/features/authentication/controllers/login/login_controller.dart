import 'package:get/get.dart';
import 'package:t_store/features/authentication/screen/forget_reset/forget_email.dart';
import 'package:t_store/features/authentication/screen/signup/signup.dart';

class LoginPageController extends GetxController {
  static LoginPageController get instance => Get.put(LoginPageController());

  // Variables

  void formpage() {}
  void rememberme() {}
  void forgotpassword() {
    Get.to(() => const ForgetPageScreen());
  }

  void signinbutton() {}
  void signupbutton() {
    Get.to(() => const SignupPage());
  }

  void signinwithgoogle() {}
  void signinwithfacebook() {}
}
