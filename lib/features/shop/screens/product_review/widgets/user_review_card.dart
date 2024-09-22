import 'package:flutter/material.dart';
// For date formatting
import 'package:readmore/readmore.dart';
import 'package:smartshop/common/widget/products/rating/rating_indicator.dart';
import 'package:smartshop/common/widget/sizebox/t_sizebox_btw_items.dart';
import 'package:smartshop/features/shop/models/product_models.dart';
import 'package:smartshop/utils/constants/colors.dart';
import 'package:smartshop/utils/constants/image_strings.dart';
import 'package:smartshop/utils/constants/sizes.dart';

class UserReviewCard extends StatelessWidget {
  const UserReviewCard({super.key, required this.product});

  final ProductModels product;

  @override
  Widget build(BuildContext context) {
    // Check if reviews are available
    if (product.reviews == null || product.reviews!.isEmpty) {
      return const Center(child: Text('No reviews available.'));
    }

    return ListView.builder(
      itemBuilder: (context, index) {
        final review = product.reviews![index];

        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      backgroundImage: AssetImage(TImages.userProfileImage2),
                    ),
                    const SizedBox(width: TSizes.spaceBtwItems),
                    Text(
                      review.reviewerName,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
              ],
            ),
            const TSizeboxBtwItems(),
            // Review with rating
            Row(
              children: [
                TRatingBarIndicator(rating: (review.rating ?? 0.0).toDouble()),
                const SizedBox(width: TSizes.spaceBtwItems),
                Text(
                  review.date.toString(), // Using intl for date
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
            const TSizeboxBtwItems(),
            ReadMoreText(
              review.comment,
              trimLines: 2,
              trimMode: TrimMode.Line,
              trimExpandedText: "  Show less",
              trimCollapsedText: "  Show more",
              moreStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: TColors.primary),
              lessStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: TColors.primary),
            ),
            const TSizeboxBtwItems(),
          ],
        );
      },
      itemCount: product.reviews!.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
    );
  }
}
