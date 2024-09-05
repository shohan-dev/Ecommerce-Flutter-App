import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:smartshop/data/repositories/autherntication/authentication_repository.dart';
import 'package:smartshop/features/authentication/screen/forget_reset/forget_email.dart';
import 'package:smartshop/features/authentication/screen/signup/signup.dart';
import 'package:smartshop/utils/constants/image_strings.dart';
import 'package:smartshop/utils/network/network_manager.dart';
import 'package:smartshop/utils/popups/full_screen_loader.dart';

class LoginPageController extends GetxController {
  static LoginPageController get instance => Get.put(LoginPageController());

  // Variables
  final rememberMe = false.obs;
  final hidePassword = true.obs;
  final localStorage = GetStorage();
  final email = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  // oninti
  @override
  void onInit() {
    // check if remember me is checked
    email.text = localStorage.read('REMEMBER_ME_EMAIL') ?? '';
    password.text = localStorage.read('REMEMBER_ME_PASSWORD') ?? '';
    rememberMe.value = localStorage.read('REMEMBER_ME_CHECKBOX') ?? false;
    super.onInit();
  }

  void formpage() {}
  void rememberme() {}
  void forgotpassword() {
    Get.to(() => const ForgetPageScreen());
  }

  Future<void> signinbutton() async {
    try {
      TFullScreenLoader.openLoadingDialog(
          "Loggin you in....", TImages.docerLoadingAnimaiton);
      // check internect connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.closeLoadingDialog();
        return;
      }
      // save data if remember me is checked
      if (rememberMe.value) {
        localStorage.write('REMEMBER_ME_EMAIL', email.text.trim());
        localStorage.write('REMEMBER_ME_PASSWORD', password.text.trim());
        localStorage.write('REMEMBER_ME_CHECKBOX', rememberMe.value);
      }
      // login using email and password
      // ignore: unused_local_variable
      final userCredentials = await AuthenticationRepository.instance
          .loginWithEmailAndPassword(
              email: email.text.trim(), password: password.text.trim());

      // remove loader
      TFullScreenLoader.closeLoadingDialog();

      // redirect
      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  void signupbutton() {
    Get.to(() => const SignupPage());
  }

  void signinwithgoogle() {}
  void signinwithfacebook() {}
}
