import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:t_store/common/widget/custom_shape/containers/rounded_container.dart';
import 'package:t_store/common/widget/products/rating/rating_indicator.dart';
import 'package:t_store/common/widget/sizebox/t_sizebox_btw_items.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

class UserReviewCard extends StatelessWidget {
  const UserReviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
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
                const SizedBox(
                  width: TSizes.spaceBtwItems,
                ),
                Text(
                  "Mahadi Hassan",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
          ],
        ),
        const TSizeboxBtwItems(),
        // Review
        Row(
          children: [
            const TRatingBarIndicator(rating: 4),
            const SizedBox(
              width: TSizes.spaceBtwItems,
            ),
            Text(
              "01 Nov, 2023",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
        const TSizeboxBtwItems(),
        const ReadMoreText(
          "The User Interface of the app is quite intuitive. I was able to navigate and make purchases Seamlessly. Great job!.",
          trimLines: 2,
          trimMode: TrimMode.Line,
          trimExpandedText: "  Show less",
          trimCollapsedText: "  Show more",
          moreStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: TColors.primary),
          lessStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: TColors.primary),
        ),
        const TSizeboxBtwItems(),
        // Company Review
        TRoundedContainer(
          backgroundColor: dark ? TColors.darkGrey : TColors.grey,
          child: Padding(
            padding: const EdgeInsets.all(TSizes.md),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "T's Store",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      "02 Nov, 2023",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
                const TSizeboxBtwItems(),
                const ReadMoreText(
                  "The User Interface of the app is quite intuitive. I was able to navigate and make purchases Seamlessly. Great job!.",
                  trimLines: 2,
                  trimMode: TrimMode.Line,
                  trimExpandedText: "  Show less",
                  trimCollapsedText: "  Show more",
                  moreStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: TColors.primary),
                  lessStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: TColors.primary),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
