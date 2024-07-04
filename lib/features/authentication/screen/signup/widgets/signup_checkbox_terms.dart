import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/common/Privacy/privacy_policy.dart';
import 'package:t_store/common/Privacy/terms_of_condition.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/constants/text_strings.dart';

class CheckboxAndTerms extends StatelessWidget {
  const CheckboxAndTerms({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(child: Checkbox(value: true, onChanged: (value) {})),
            const Text(TTexts.iAgreeTo),
            const SizedBox(width: 3),
            GestureDetector(
              onTap: () {
                Get.to(() => const PrivacyPolicyPage());
              },
              child: const Text(
                TTexts.privacyPolicy,
                style: TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            const SizedBox(width: 3),
            const Text(TTexts.and),
            const SizedBox(width: 3),
            GestureDetector(
              onTap: () {
                Get.to(() => const TermsConditionsPage());
              },
              child: const Text(
                TTexts.termsOfUse,
                style: TextStyle(
                  color: Colors.blue,
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
