import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartshop/features/authentication/controllers/signup/signup_controller.dart';
import 'package:smartshop/utils/constants/sizes.dart';
import 'package:smartshop/utils/constants/text_strings.dart';

class SignupButton extends StatelessWidget {
  const SignupButton({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());

    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
              onPressed: () {
                controller.signup();
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
