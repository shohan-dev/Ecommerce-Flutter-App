import 'package:flutter/material.dart';
import 'package:smartshop/features/shop/models/product_models.dart';
import 'package:smartshop/features/shop/screens/product_review/widgets/progress_indicator_and_rating.dart';

class TOverallProductRating extends StatelessWidget {
  const TOverallProductRating({
    Key? key,
    required this.product,
  }) : super(key: key);

  final ProductModels product;

  @override
  Widget build(BuildContext context) {
    final reviews = product.reviews ?? [];
    final totalReviews = reviews.length;

    // Edge case: If no reviews, show a default 0.0 rating
    if (totalReviews == 0) {
      return Center(
        child: Text(
          'No reviews yet',
          style: Theme.of(context).textTheme.displayLarge,
        ),
      );
    }

    // Calculate the count of each rating (1-5)
    final List<int> ratingCounts = List<int>.filled(5, 0);
    for (var review in reviews) {
      if (review.rating != null && review.rating! >= 1 && review.rating! <= 5) {
        ratingCounts[review.rating!.toInt() - 1]++;
      }
    }

    // Calculate the overall rating
    final double overallRating =
        ratingCounts.asMap().entries.fold(0.0, (sum, entry) {
              final index = entry.key;
              final count = entry.value;
              return sum +
                  (count * (index + 1)); // index + 1 gives the rating (1-5)
            }) /
            totalReviews;

    // Calculate the values for the progress indicators, setting progress to 0 for counts with no reviews
    final List<double> progressValues = ratingCounts.map((count) {
      return count > 0
          ? count / totalReviews
          : 0.0; // Only non-zero counts should have progress
    }).toList();

    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                overallRating.toStringAsFixed(1), // Display overall rating
                style: Theme.of(context).textTheme.displayLarge,
              ),
              const SizedBox(height: 4),
              Text(
                '$totalReviews reviews', // Display total reviews count
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
        Expanded(
          flex: 7,
          child: Column(
            children: [
              for (int i = 5; i >= 1; i--)
                TRatingProgressIndicator(
                  text: '$i', // Display rating number
                  value: progressValues[i - 1], // Proportion for this rating
                  totalCount:
                      ratingCounts[i - 1], // Count of reviews for this rating
                ),
            ],
          ),
        ),
      ],
    );
  }
}
