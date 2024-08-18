import 'package:get/get.dart';
import 'package:smartshop/features/authentication/screen/forget_reset/forget_email.dart';
import 'package:smartshop/features/authentication/screen/signup/signup.dart';
import 'package:smartshop/navigation_menu.dart';

class LoginPageController extends GetxController {
  static LoginPageController get instance => Get.put(LoginPageController());

  // Variables

  void formpage() {}
  void rememberme() {}
  void forgotpassword() {
    Get.to(() => const ForgetPageScreen());
  }

  void signinbutton() {
    Get.offAll(() => const NavigationMenuPage());
  }

  void signupbutton() {
    Get.to(() => const SignupPage());
  }

  void signinwithgoogle() {}
  void signinwithfacebook() {}
}
