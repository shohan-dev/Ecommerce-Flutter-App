import 'package:flutter/material.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/text_strings.dart';

class DeviderWithText extends StatelessWidget {
  const DeviderWithText({
    super.key,
    required this.dark,
  });

  final bool dark;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Divider(
            color: dark
                ? TColors.grey
                : TColors
                    .darkGrey, // Example of conditional color based on dark mode
            thickness: 1,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            TTexts.orSignInWith,
            style: TextStyle(
                color: dark
                    ? TColors.grey
                    : TColors
                        .darkGrey), // Example of conditional color for text based on dark mode
          ),
        ),
        Expanded(
          child: Divider(
            color: dark
                ? TColors.grey
                : TColors
                    .darkGrey, // Example of conditional color based on dark mode
            thickness: 1,
          ),
        ),
      ],
    );
  }
}