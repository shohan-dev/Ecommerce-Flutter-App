import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/features/authentication/controllers/login/login_controller.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/constants/text_strings.dart';

class FormPageLogin extends StatelessWidget {
  const FormPageLogin({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: TSizes.spaceBtwInputFields),
      child: Form(
        child: Column(
          children: [
            // Email field
            TextFormField(
              decoration: const InputDecoration(
                prefixIcon: Icon(Iconsax.direct_right),
                labelText: TTexts.email,
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwInputFields),

            // Password field
            TextFormField(
              obscureText: true,
              decoration: const InputDecoration(
                prefixIcon: Icon(Iconsax.password_check),
                suffixIcon: Icon(Iconsax.eye_slash),
                labelText: TTexts.password,
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwInputFields),
            // CheckBox
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Checkbox(value: true, onChanged: (value) {}),
                    const Text(TTexts.rememberMe),
                  ],
                ),
                const Text(TTexts.forgetPassword),
              ],
            ),

            const SizedBox(height: TSizes.spaceBtwSections),
            // button signin
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
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
        ),
      ),
    );
  }
}
