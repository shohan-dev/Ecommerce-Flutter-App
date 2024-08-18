import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:smartshop/common/widget/Verify/t_verify_text.dart';
import 'package:smartshop/common/widget/button/add_to_cart_button.dart';
import 'package:smartshop/common/widget/custom_shape/containers/rounded_container.dart';
import 'package:smartshop/common/widget/icons/circular_icons.dart';
import 'package:smartshop/common/widget/images/t_round_images.dart';
import 'package:smartshop/common/widget/texts/product_price_text.dart';
import 'package:smartshop/common/widget/texts/product_title.dart';
import 'package:smartshop/utils/constants/colors.dart';
import 'package:smartshop/utils/constants/image_strings.dart';
import 'package:smartshop/utils/constants/sizes.dart';
import 'package:smartshop/utils/helpers/helper_functions.dart';

class TProductCardHorizontal extends StatelessWidget {
  const TProductCardHorizontal({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Container(
      width: 310,
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(TSizes.productImageRadius),
        color: dark ? TColors.darkContainer : TColors.white,
      ),
      child: Stack(
        children: [
          Row(
            children: [
              // Thumbnail
              TRoundedContainer(
                height: 120,
                width: 120,
                padding: const EdgeInsets.all(TSizes.sm),
                backgroundColor: dark
                    ? TColors.darkContainer.withOpacity(0.04)
                    : TColors.light,
                child: Stack(
                  children: [
                    const SizedBox(
                      height: 120,
                      width: 120,
                      child: TRoundImage(
                        imageUrl: TImages.productImage1,
                        applyImageRadius: true,
                      ),
                    ),
                    Positioned(
                      top: 6,
                      left: 6,
                      child: TRoundedContainer(
                        height: 23,
                        width: 40,
                        radius: TSizes.sm,
                        backgroundColor: TColors.secondary.withOpacity(0.8),
                        padding: const EdgeInsets.symmetric(
                            horizontal: TSizes.sm, vertical: TSizes.xs),
                        child: Text(
                          "25%",
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .apply(color: TColors.black),
                        ),
                      ),
                    ),
                    // Heart Icon
                    const Positioned(
                      top: 2,
                      right: 2,
                      child: TCircularIcon(
                        height: 30,
                        width: 30,
                        icon: Iconsax.heart5,
                        color: Colors.red,
                        size: 15, // Adjusted size for better fit
                      ),
                    ),
                  ],
                ),
              ),
              // Details
              const Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: TSizes.sm, top: TSizes.sm),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TProductTitle(
                        title: "Green Nike Half Sleeves",
                        smallSize: true,
                      ),
                      SizedBox(
                        height: TSizes.spaceBtwItems / 2,
                      ),
                      TVerifyText(text: "Nike"),
                      SizedBox(height: TSizes.sm),
                      TProductPriceText(price: "256"),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const Positioned(
            bottom: 0,
            right: 0,
            child: TAddToCartButton(),
          ),
        ],
      ),
    );
  }
}
