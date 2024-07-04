import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/common/styles/spacing_styles.dart';
import 'package:t_store/features/authentication/controllers/signup/signup_controller.dart';
import 'package:t_store/features/authentication/screen/signup/widgets/signup_button.dart';
import 'package:t_store/features/authentication/screen/signup/widgets/signup_checkbox_terms.dart';
import 'package:t_store/features/authentication/screen/signup/widgets/signup_footer.dart';
import 'package:t_store/features/authentication/screen/signup/widgets/signup_form.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/constants/text_strings.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

// // Controller for SignupPage
// class SignupController extends GetxController {
//   final firstNameController = TextEditingController();
//   final lastNameController = TextEditingController();
//   final isDarkMode = false.obs;

//   @override
//   void onInit() {
//     super.onInit();
//     isDarkMode.value = THelperFunctions.isDarkMode(Get.context!);
//   }
// }

class SignupPage extends StatelessWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Initialize the controller
    final SignupController controller = Get.put(SignupController());
    final dark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: TSpacingStyle.paddingwithAppBarHeight,
          child: Column(
            children: [
              const SizedBox(
                height: TSizes.appBarHeight,
              ),
              // header
              Text(
                TTexts.signupTitle,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(
                height: TSizes.spaceBtwInputFields + 10,
              ),

              // form fields
              const LoginPageForm(),

              // checkboxes
              CheckboxAndTerms(
                dark: dark,
              ),

              // Signup button
              const SignupButton(),

              // Footer
              SignupFooter(dark: dark),
            ],
          ),
        ),
      ),
    );
  }
}
