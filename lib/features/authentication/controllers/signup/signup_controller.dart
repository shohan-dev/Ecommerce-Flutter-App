import 'package:get/get.dart';
import 'package:smartshop/common/Privacy/privacy_policy.dart';
import 'package:smartshop/common/Privacy/terms_of_condition.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  void privacyPolicyChanged() {
    Get.to(() => const PrivacyPolicyPage());
  }

  void termsOfServiceChanged() {
    Get.to(() => const TermsConditionsPage());
  }
}
