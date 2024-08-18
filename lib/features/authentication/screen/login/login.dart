import 'package:flutter/material.dart';
import 'package:smartshop/common/styles/devider_styles.dart';
import 'package:smartshop/common/styles/spacing_styles.dart';
import 'package:smartshop/features/authentication/screen/login/widgets/login_button.dart';
import 'package:smartshop/features/authentication/screen/login/widgets/login_footer.dart';
import 'package:smartshop/features/authentication/screen/login/widgets/login_form.dart';
import 'package:smartshop/features/authentication/screen/login/widgets/login_header.dart';
import 'package:smartshop/utils/constants/sizes.dart';
import 'package:smartshop/utils/constants/text_strings.dart';
import 'package:smartshop/utils/helpers/helper_functions.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: TSpacingStyle.paddingwithAppBarHeight,
          child: Column(
            children: [
              // header page
              LoginHeaderPage(dark: dark),
              const SizedBox(height: TSizes.spaceBtwInputFields),

              // form page
              const FormPageLogin(),
              // Login Button
              const LoginButton(),

              // Divider with text
              DeviderWithText(
                dark: dark,
                text: TTexts.orSignInWith,
              ),

              // Footer
              const FooterPageLogin(),
            ],
          ),
        ),
      ),
    );
  }
}
