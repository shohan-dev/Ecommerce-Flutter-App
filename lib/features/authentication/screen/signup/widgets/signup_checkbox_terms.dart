import 'package:flutter/material.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/constants/text_strings.dart';

class CheckboxAndTerms extends StatelessWidget {
  const CheckboxAndTerms({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(child: Checkbox(value: true, onChanged: (value) {})),
            const Text(TTexts.iAgreeTo),
            const SizedBox(
              width: 3,
            ),
            const Text(TTexts.privacyPolicy),
            const SizedBox(
              width: 3,
            ),
            const Text(TTexts.and),
            const SizedBox(
              width: 3,
            ),
            const Text(TTexts.termsOfUse),
          ],
        ),
        const SizedBox(
          height: TSizes.spaceBtwInputFields + 10,
        ),
      ],
    );
  }
}
