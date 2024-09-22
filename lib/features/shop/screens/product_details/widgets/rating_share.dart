import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:smartshop/utils/constants/sizes.dart';

class TRatingShare extends StatelessWidget {
  final double? rating; // Define the rating variable
  final int length; // Define the length variable

  const TRatingShare(
    this.rating,
    this.length, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const Icon(
              Iconsax.star5,
              color: Colors.amber,
              size: 24,
            ),
            const SizedBox(
              width: TSizes.spaceBtwItems / 2,
            ),
            // Ensure that rating is displayed properly
            Text(rating != null ? rating!.toStringAsFixed(1) : 'N/A'),
            const SizedBox(width: TSizes.spaceBtwItems / 2),
            Text("($length)"),
          ],
        ),
        IconButton(
          onPressed: () {
            // Implement your share functionality here
          },
          icon: const Icon(Icons.share),
        ),
      ],
    );
  }
}
