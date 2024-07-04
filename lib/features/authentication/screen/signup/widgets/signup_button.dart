import 'package:flutter/material.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/constants/text_strings.dart';

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
              onPressed: () {}, child: const Text(TTexts.createAccount)),
        ),
        const SizedBox(
          height: TSizes.spaceBtwInputFields,
        ),
      ],
    );
  }
}
