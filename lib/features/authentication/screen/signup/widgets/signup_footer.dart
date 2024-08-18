import 'package:flutter/material.dart';
import 'package:smartshop/common/styles/circle_border_icon_image.dart';
import 'package:smartshop/common/styles/devider_styles.dart';
import 'package:smartshop/utils/constants/image_strings.dart';
import 'package:smartshop/utils/constants/sizes.dart';
import 'package:smartshop/utils/constants/text_strings.dart';

class SignupFooter extends StatelessWidget {
  const SignupFooter({
    super.key,
    required this.dark,
  });

  final bool dark;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DeviderWithText(
          dark: dark,
          text: TTexts.orSignUpWith,
        ),
        const SizedBox(
          height: TSizes.spaceBtwInputFields,
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleIconImage(
              image: TImages.google,
            ),
            SizedBox(
              width: TSizes.spaceBtwItems,
            ),
            CircleIconImage(
              image: TImages.facebook,
            ),
          ],
        ),
      ],
    );
  }
}
