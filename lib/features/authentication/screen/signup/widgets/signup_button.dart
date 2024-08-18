import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartshop/features/authentication/screen/signup/verify_email.dart';
import 'package:smartshop/utils/constants/sizes.dart';
import 'package:smartshop/utils/constants/text_strings.dart';

class SignupButton extends StatelessWidget {
  const SignupButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
              onPressed: () {
                Get.off(() => const VerifyEmailScreen());
              },
              child: const Text(TTexts.createAccount)),
        ),
        const SizedBox(
          height: TSizes.spaceBtwInputFields,
        ),
      ],
    );
  }
}
