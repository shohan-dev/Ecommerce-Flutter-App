import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:smartshop/utils/constants/colors.dart';
import 'package:smartshop/utils/constants/sizes.dart';
import 'package:smartshop/utils/helpers/helper_functions.dart';

class TVerifyText extends StatelessWidget {
  const TVerifyText({
    Key? key,
    this.iconSize = TSizes.iconXs,
    this.icon = Iconsax.verify5,
    required this.text,
    this.iconColor = TColors.primary,
    this.textsize, // Remove default value here
  }) : super(key: key);

  final double iconSize;
  final TextStyle? textsize; // Optional, no default value
  final IconData icon;
  final String text;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    // Handle text style based on the current context
    final textStyle = textsize ??
        TextStyle(
          fontSize: 11,
          color: THelperFunctions.isDarkMode(context)
              ? Colors.white38
              : Colors.black26,
        );

    return Row(
      children: [
        Text(
          text,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: textStyle,
        ),
        Icon(
          icon,
          color: iconColor,
          size: iconSize,
        ),
      ],
    );
  }
}
