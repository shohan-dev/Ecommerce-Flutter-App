import 'package:get/get.dart';
import 'package:t_store/common/Privacy/privacy_policy.dart';
import 'package:t_store/common/Privacy/terms_of_condition.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.put(SignupController());
  // final firstNameController = TextEditingController();
  // final lastNameController = TextEditingController();
  // final isDarkMode = false.obs;

  // @override
  // void onInit() {
  //   super.onInit();
  //   isDarkMode.value = THelperFunctions.isDarkMode(Get.context!);
  // }

  void privacyPolicyChanged() {
    Get.to(() => const PrivacyPolicyPage());
  }

  void termsOfServiceChanged() {
    Get.to(() => const TermsConditionsPage());
  }
}
