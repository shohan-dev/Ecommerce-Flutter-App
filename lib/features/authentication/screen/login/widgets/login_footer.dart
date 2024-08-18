import 'package:flutter/material.dart';
import 'package:smartshop/common/styles/circle_border_icon_image.dart';
import 'package:smartshop/utils/constants/image_strings.dart';
import 'package:smartshop/utils/constants/sizes.dart';

class FooterPageLogin extends StatelessWidget {
  const FooterPageLogin({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(TSizes.spaceBtwInputFields),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        CircleIconImage(image: TImages.google),
        SizedBox(
          width: TSizes.spaceBtwInputFields,
        ),
        CircleIconImage(image: TImages.facebook),
      ]),
    );
  }
}
