import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:smartshop/features/authentication/screen/login/login.dart';
import 'package:smartshop/features/authentication/screen/onboarding/onboarding.dart';
import 'package:smartshop/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:smartshop/utils/exceptions/firebase_exceptions.dart';
import 'package:smartshop/utils/exceptions/format_exceptions.dart';
import 'package:smartshop/utils/exceptions/platform_exceptions.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  final GetStorage deviceStorage = GetStorage();
  final _auth = FirebaseAuth.instance;

  @override
  void onReady() {
    FlutterNativeSplash.remove();
    screenRedirect();
  }

  void screenRedirect() async {
    bool isFirstTime = deviceStorage.read('isFirstTime') ?? true;

    if (isFirstTime) {
      deviceStorage.write('isFirstTime', false);
      Get.offAll(() => const OnBoardingScreen());
    } else {
      Get.offAll(() => const LoginPage());
    }
  }

  Future<UserCredential> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      // Attempt to create a user with email and password
      return await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      // Handle FirebaseAuthException
      throw TFirebaseAuthException(e.code);
    } on FirebaseException catch (e) {
      // Handle FirebaseException
      throw TFirebaseException(e.code);
    } on FormatException catch (_) {
      // Handle FormatException
      throw const TFormatException();
    } on PlatformException catch (e) {
      // Handle PlatformException
      throw TPlatformException(e.code);
    } catch (e) {
      // Handle any other exceptions
      throw 'Something went wrong. Please try again.';
    }
  }
}
