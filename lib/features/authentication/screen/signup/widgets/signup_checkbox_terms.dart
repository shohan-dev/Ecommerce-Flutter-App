import 'package:flutter/material.dart';
import 'package:t_store/features/authentication/controllers/signup/signup_controller.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/constants/text_strings.dart';

class CheckboxAndTerms extends StatelessWidget {
  const CheckboxAndTerms({
    super.key,
    required this.dark,
  });

  final bool dark;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(child: Checkbox(value: true, onChanged: (value) {})),
            const Text(TTexts.iAgreeTo),
            const SizedBox(width: 3),
            // privacy policy
            GestureDetector(
              onTap: () {
                SignupController.instance.privacyPolicyChanged();
              },
              child: Text(
                TTexts.privacyPolicy,
                style: TextStyle(
                  color: dark ? Colors.white : Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            const SizedBox(width: 3),
            const Text(TTexts.and),
            const SizedBox(width: 3),
            //  terms of condition
            GestureDetector(
              onTap: () {
                SignupController.instance.termsOfServiceChanged();
              },
              child: Text(
                TTexts.termsOfUse,
                style: TextStyle(
                  color: dark ? Colors.white : Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwInputFields + 10),
      ],
    );
  }
}
