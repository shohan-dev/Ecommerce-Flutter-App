import 'package:flutter/material.dart';
import 'package:smartshop/common/styles/spacing_styles.dart';
import 'package:smartshop/features/authentication/screen/signup/widgets/signup_button.dart';
import 'package:smartshop/features/authentication/screen/signup/widgets/signup_checkbox_terms.dart';
import 'package:smartshop/features/authentication/screen/signup/widgets/signup_footer.dart';
import 'package:smartshop/features/authentication/screen/signup/widgets/signup_form.dart';
import 'package:smartshop/utils/constants/sizes.dart';
import 'package:smartshop/utils/constants/text_strings.dart';
import 'package:smartshop/utils/helpers/helper_functions.dart';



class SignupPage extends StatelessWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
