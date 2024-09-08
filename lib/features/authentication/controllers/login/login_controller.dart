import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:smartshop/common/widget/snackbar/snackbar.dart';
import 'package:smartshop/data/repositories/autherntication/authentication_repository.dart';
import 'package:smartshop/features/authentication/screen/forget_password/forget_password.dart';
import 'package:smartshop/features/authentication/screen/signup/signup.dart';
import 'package:smartshop/features/personailzation/controllers/user_controllers.dart';
import 'package:smartshop/navigation_menu.dart';
import 'package:smartshop/utils/constants/image_strings.dart';
import 'package:smartshop/utils/network/network_manager.dart';
import 'package:smartshop/utils/popups/full_screen_loader.dart';

class LoginPageController extends GetxController {
  static LoginPageController get instance => Get.put(LoginPageController());

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

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
      // validate form
      if (!loginFormKey.currentState!.validate()) {
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
      await AuthenticationRepository.instance.loginWithEmailAndPassword(
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

  void signinwithfacebook() {
    TLoaders.warningSnackBar(
        title: "Coming Soon",
        message: "Facebook login will be implemented soon");
  }

// Modified Google Sign-In method with loading dialog and error handling
  Future<void> signinWithGoogle() async {
    // Open loading dialog
    TFullScreenLoader.openLoadingDialog(
        "Logging you in....", TImages.docerLoadingAnimaiton);

    try {
      // Check internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        // Close the loading dialog and show an error if there's no internet
        TFullScreenLoader.closeLoadingDialog();
        TLoaders.errorSnackBar(
            title: "Network Error", message: "No internet connection.");
        return;
      }

      // Trigger the Google Authentication flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        // If the user cancels the sign-in process
        TFullScreenLoader.closeLoadingDialog();
        TLoaders.errorSnackBar(
            title: "Sign-In Cancelled",
            message: "User cancelled the sign-in process.");
        return;
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential using the obtained access and ID tokens
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the obtained credential
      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);


      // Check if the user exists in Firebase
      final isEmailExist =
          await AuthenticationRepository.instance.checkIfUserExists(
        userCredential.user!.email!,
      );

      // If the user does not exist, save the user data

      if (!isEmailExist) {
        await UserControllers.instance.saveUserRecord(userCredential);
      }

      // Close the loading dialog after successful sign-in
      TFullScreenLoader.closeLoadingDialog();
      Get.offAll(() => const NavigationMenuPage());
    } catch (e) {
      // Close the loading dialog in case of an error
      TFullScreenLoader.closeLoadingDialog();

      // Log the error for debugging
      if (kDebugMode) {
        print("Error during Google sign-in: $e");
      }

      // Show an error message to the user
      TLoaders.errorSnackBar(title: "Sign-In Error", message: e.toString());
    }
  }
}
