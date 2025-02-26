import 'package:flutter/material.dart';
import 'package:smartshop/utils/constants/colors.dart';
import 'package:smartshop/utils/constants/sizes.dart';

class CircleIconImage extends StatelessWidget {
  const CircleIconImage({
    Key? key, // Corrected super.key to Key? key
    required this.image,
    this.onTap,
  }) : super(key: key);

  final String image;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: TColors.grey),
        shape: BoxShape.circle, // Use shape for circular border
      ),
      child: IconButton(
        onPressed: onTap,
        icon: Image.asset(
          image,
          height: TSizes.iconMd,
          width: TSizes.iconMd,
        ),
      ),
    );
  }
}
