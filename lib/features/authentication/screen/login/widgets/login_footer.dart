import 'package:flutter/material.dart';
import 'package:t_store/common/styles/circle_border_icon_image.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/constants/sizes.dart';

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
