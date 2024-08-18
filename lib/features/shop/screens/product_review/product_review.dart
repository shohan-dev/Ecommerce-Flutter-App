import 'package:flutter/material.dart';
import 'package:smartshop/common/widget/appbar/appbar.dart';
import 'package:smartshop/common/widget/products/rating/rating_indicator.dart';
import 'package:smartshop/common/widget/sizebox/t_sizebox_btw_items.dart';
import 'package:smartshop/features/shop/screens/product_review/widgets/rating_progress_indicator.dart';
import 'package:smartshop/features/shop/screens/product_review/widgets/user_review_card.dart';
import 'package:smartshop/utils/constants/sizes.dart';

class ProductReviewScreen extends StatelessWidget {
  const ProductReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TAppBar(
        showBackArrow: true,
        title: Text("Reviews & Rating"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                  "Rating and reviews are verified and are from prople who use the same type of device that you use."),
              const TSizeboxBtwItems(),
              // Overall Product Rating
              const TOverallProductRating(),
              const TRatingBarIndicator(
                rating: 3.5,
              ),
              Text(
                "12,611",
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const TSizeboxBtwItems(),
              // User Reviews List
              const UserReviewCard(),
            ],
          ),
        ),
      ),
    );
  }
}
