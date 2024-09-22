import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:iconsax/iconsax.dart';
import 'package:smartshop/utils/constants/colors.dart';

class TRatingBarIndicator extends StatelessWidget {
  const TRatingBarIndicator({
    super.key,
    required this.rating,
    this.itemSize = 20.0, // Default item size
    this.maxRating = 5.0, // Optional max rating
  });

  final double rating;
  final double itemSize;
  final double maxRating;

  @override
  Widget build(BuildContext context) {
    return RatingBarIndicator(
      rating: rating,
      itemSize: itemSize, // Use customizable item size
      unratedColor: TColors.grey,
      itemBuilder: (_, __) => const Icon(
        Iconsax.star1,
        color: TColors.primary,
      ),
    );
  }
}
