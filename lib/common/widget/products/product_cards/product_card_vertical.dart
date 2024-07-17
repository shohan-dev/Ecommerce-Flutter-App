import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/common/widget/custom_shape/containers/rounded_container.dart';
import 'package:t_store/common/widget/icons/circular_icons.dart';
import 'package:t_store/common/widget/images/t_round_images.dart';
import 'package:t_store/common/widget/texts/product_title.dart';
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
      onTap: () {},
      child: Container(
        width: 180,
        color: TColors.grey.withOpacity(0.1),
        padding: const EdgeInsets.all(1),
        child: Column(
          children: [
            // Container
            TRoundedContainer(
              height: 180,
              padding: const EdgeInsets.all(TSizes.sm),
              backgroundColor: dark ? TColors.dark : TColors.light,
              child: Positioned(
                top: 12,
                child: Stack(
                  children: [
                    const TRoundImage(imageUrl: TImages.productImage1), // image
                    Padding(
                      padding: const EdgeInsets.only(top: 8, left: 5),
                      child: TRoundedContainer(
                        radius: TSizes.sm,
                        backgroundColor: TColors.secondary.withOpacity(0.8),
                        padding: const EdgeInsets.symmetric(
                            horizontal: TSizes.sm, vertical: TSizes.xs),
                        child: const Text("25%"), // Discount
                      ),
                    ),

                    const Positioned(
                      top: 0,
                      right: 0,
                      child: TCircularIcon(
                        height: 40,
                        width: 40,
                        icon: Iconsax.heart5, // Favorite Cart
                        color: Colors.red,
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: TSizes.xs,
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TProductTitle(
                    title: "Green Nike air Shoes",
                    smallSize: true,
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwItems / 2,
                  ),
                  Row(
                    children: [
                      Text(
                        "Nike",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      const Icon(
                        Iconsax.verify5,
                        color: TColors.primary,
                        size: TSizes.iconXs,
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "\$35.5",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      Container(
                          decoration: const BoxDecoration(
                              color: TColors.dark,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(TSizes.cardRadiusMd),
                                  bottomRight: Radius.circular(
                                      TSizes.productImageRadius))),
                          child: const SizedBox(
                            height: TSizes.iconLg * 1.2,
                            width: TSizes.iconLg * 1.2,
                            child: Icon(
                              Iconsax.add,
                              color: TColors.light,
                            ),
                          ))
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
