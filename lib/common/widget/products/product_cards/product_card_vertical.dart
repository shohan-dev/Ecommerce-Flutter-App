import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/common/widget/Verify/t_verify_text.dart';
import 'package:t_store/common/widget/button/add_to_cart_button.dart';
import 'package:t_store/common/widget/custom_shape/containers/rounded_container.dart';
import 'package:t_store/common/widget/icons/circular_icons.dart';
import 'package:t_store/common/widget/images/t_round_images.dart';
import 'package:t_store/common/widget/texts/product_title.dart';
import 'package:t_store/features/shop/screens/product_details/product_details.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

class TProductCardVertical extends StatelessWidget {
  const TProductCardVertical({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return GestureDetector(
      onTap: () => Get.to(() => const ProductDetailScreen()),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: TColors.grey.withOpacity(0.1),
        ),
        child: Column(
          children: [
            // Container for Image and Icons
            TRoundedContainer(
              height: 186,
              padding: const EdgeInsets.all(TSizes.sm),
              backgroundColor: dark
                  ? TColors.darkContainer.withOpacity(0.01)
                  : TColors.light,
              child: Stack(
                children: [
                  const TRoundImage(imageUrl: TImages.productImage1), // Image
                  Positioned(
                    top: 8,
                    left: 5,
                    child: TRoundedContainer(
                      radius: TSizes.sm,
                      backgroundColor: TColors.secondary.withOpacity(0.8),
                      padding: const EdgeInsets.symmetric(
                          horizontal: TSizes.sm, vertical: TSizes.xs),
                      child: const Text(
                        "25%",
                        style: TextStyle(color: TColors.black),
                      ), // Discount
                    ),
                  ),
                  const Positioned(
                    top: 2,
                    right: 2,
                    child: TCircularIcon(
                      height: 40,
                      width: 40,
                      icon: Iconsax.heart5, // Favorite Icon
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: TSizes.xs),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 8, left: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TProductTitle(
                      title: "Green Nike Air Shoes",
                      smallSize: true,
                    ),
                    const SizedBox(height: TSizes.spaceBtwItems / 2),
                    // Nikey verify
                    const TVerifyText(
                      text: 'Nike',
                    ),
                    const Spacer(), // Pushes the last row to the bottom
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "\$35.6",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        const TAddToCartButton(),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
