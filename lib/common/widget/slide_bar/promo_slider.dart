import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smartshop/common/widget/custom_shape/containers/circular_container.dart';
import 'package:smartshop/common/widget/effect/catagories_shimmer_effect.dart';
import 'package:smartshop/common/widget/images/t_round_images.dart';
import 'package:smartshop/features/shop/controllers/banners_controller.dart';
import 'package:smartshop/utils/constants/colors.dart';
import 'package:smartshop/utils/constants/sizes.dart';

class TPromoSlider extends StatelessWidget {
  const TPromoSlider({super.key});

  @override
  Widget build(BuildContext context) {
    final BannersController controller =
        Get.find(); // Fetch the controller instance

    return Obx(() {
      // Show shimmer effect while loading
      if (controller.isLoading.value) {
        return const TCategoryShimmer();
      }

      // Display a message if no banners are found
      if (controller.banners.isEmpty) {
        return Center(
          child: Text(
            'No Banners Found',
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: TColors.white),
          ),
        );
      }

      // Display carousel slider with banners
      return Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            CarouselSlider(
              options: CarouselOptions(
                viewportFraction: 1,
                onPageChanged: (index, _) => controller.updatePageIndex(index),
              ),
              items: controller.banners.map((banner) {
                return TRoundImage(
                  imageUrl: banner.imageUrl,
                  isNetworkImage: true,
                  onPressed: () {
                    // Add the banner on tap action here
                    print('Banner tapped ${banner.targetScreen}');
                    Get.toNamed(banner.targetScreen);
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: TSizes.spaceBtwItems),
            _buildIndicator(controller),
          ],
        ),
      );
    });
  }

  // Build the indicator dots for the carousel
  Widget _buildIndicator(BannersController controller) {
    return Obx(() {
      return Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(
            controller.banners.length,
            (index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: TCircularContainer(
                width: 8,
                height: 8,
                backgroundColor: controller.carousalCurrentIndex.value == index
                    ? TColors.primary
                    : TColors.grey,
              ),
            ),
          ),
        ),
      );
    });
  }
}
