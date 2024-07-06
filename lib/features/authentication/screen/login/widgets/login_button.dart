import 'package:flutter/material.dart';
import 'package:t_store/features/authentication/controllers/login/login_controller.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/constants/text_strings.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // button signin
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              LoginPageController.instance.signinbutton();
            },
            child: const Text(TTexts.signIn),
          ),
        ),
        const SizedBox(height: TSizes.defaultSpace),
        // button signup
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: () {
              LoginPageController.instance.signupbutton();
            },
            child: const Text(TTexts.createAccount),
          ),
        ),
        const SizedBox(height: TSizes.defaultSpace),
      ],
    );
  }
}
