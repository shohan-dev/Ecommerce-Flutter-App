import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:smartshop/features/authentication/screen/login/login.dart';
import 'package:smartshop/features/authentication/screen/onboarding/onboarding.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  final GetStorage deviceStorage = GetStorage();

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
}
