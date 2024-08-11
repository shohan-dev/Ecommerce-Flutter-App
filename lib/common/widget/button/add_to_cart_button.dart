import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

class TAddToCartButton extends StatelessWidget {
  const TAddToCartButton({
    super.key,
    this.height = TSizes.iconLg * 1.3,
    this.width = TSizes.iconLg * 1.3,
  });

  final double height, width;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Container(
      decoration: BoxDecoration(
        color: dark ? TColors.primary : TColors.dark,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(TSizes.cardRadiusMd),
          bottomRight: Radius.circular(TSizes.productImageRadius),
        ),
      ),
      child: SizedBox(
        height: height,
        width: width,
        child: const Icon(
          Iconsax.add,
          color: TColors.light,
        ),
      ),
    );
  }
}
