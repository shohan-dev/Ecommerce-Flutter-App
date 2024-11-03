import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';
import 'package:smartshop/common/widget/products/rating/rating_indicator.dart';
import 'package:smartshop/common/widget/sizebox/t_sizebox_btw_items.dart';
import 'package:smartshop/utils/constants/colors.dart';
import 'package:smartshop/utils/constants/image_strings.dart';
import 'package:smartshop/utils/constants/sizes.dart';

class UserReviewCard extends StatelessWidget {
  UserReviewCard({
    super.key,
    required Future<List<Map<String, dynamic>>> reviewlist,
  }) {
    // Fetch initial reviews when the widget is created
    controller.fetchReviews(reviewlist);
  }

  final ReviewController controller = Get.put(ReviewController());

  @override
  Widget build(BuildContext context) {

    return Obx(() {
      if (controller.reviews.isEmpty) {
        return const Center(child: Text('No reviews available.'));
      }

      return ListView.builder(
        itemCount: controller.reviews.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          final review = controller.reviews[index];

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                        review['reviewerName'] ?? 'Unknown Reviewer',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ],
                  ),
                ],
              ),
              const TSizeboxBtwItems(),
              // Rating and date row
              Row(
                children: [
                  TRatingBarIndicator(
                      rating: (review['rating'] ?? 0.0).toDouble()),
                  const SizedBox(width: TSizes.spaceBtwItems),
                  Text(
                    review['date']?.toString() ?? 'No date',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
              const TSizeboxBtwItems(),
              // Review comment with ReadMoreText
              ReadMoreText(
                review['comment'] ?? 'No comment provided',
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
              const Divider(),
            ],
          );
        },
      );
    });
  }
}

class ReviewController extends GetxController {
  // Reactive list of reviews
  var reviews = <Map<String, dynamic>>[].obs;

  // Method to fetch reviews from a Future
  Future<void> fetchReviews(
      Future<List<Map<String, dynamic>>> reviewListFuture) async {
    try {
      // Load reviews and update reactive list
      final data = await reviewListFuture;
      reviews.assignAll(data);
    } catch (e) {
      // Handle error as needed
      print("Failed to fetch reviews: $e");
    }
  }
}
