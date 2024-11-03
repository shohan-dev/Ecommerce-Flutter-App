import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartshop/common/widget/appbar/appbar.dart';
import 'package:smartshop/common/widget/products/rating/rating_indicator.dart';
import 'package:smartshop/common/widget/sizebox/t_sizebox_btw_items.dart';
import 'package:smartshop/features/shop/controllers/review/review_controller.dart';
import 'package:smartshop/features/shop/models/product_models.dart';
import 'package:smartshop/features/shop/screens/product_review/widgets/rating_progress_indicator.dart';
import 'package:smartshop/features/shop/screens/product_review/widgets/user_review_card.dart';
import 'package:smartshop/features/shop/screens/product_review/widgets/write_a_review.dart';
import 'package:smartshop/utils/constants/sizes.dart';

class ProductReviewScreen extends StatelessWidget {
  const ProductReviewScreen({super.key, required this.product});

  final ProductModels product;

  @override
  Widget build(BuildContext context) {
    final reviewControllerFuture =
        WriteReviewController().fetch_rating_review(product.id!.toString());
    var reviewlist = reviewControllerFuture.then((value) => value);

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
              TOverallProductRating(product: product),
              TRatingBarIndicator(
                rating: product.rating!.toDouble(),
              ),
              Text(
                "${product.reviews!.length} Reviews",
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const TSizeboxBtwItems(),

              // Rating Progress Indicator
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.to(() => WriteReviewForm(
                            product: product,
                          ));
                    },
                    child: Text(
                      "Write a Review",
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ],
              ),

              // User Reviews List
              UserReviewCard(reviewlist: reviewlist),
            ],
          ),
        ),
      ),
    );
  }
}
