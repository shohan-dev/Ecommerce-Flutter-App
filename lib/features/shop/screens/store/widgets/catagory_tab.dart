import 'package:flutter/material.dart';
import 'package:t_store/common/widget/brands/brandsCards.dart';
import 'package:t_store/common/widget/brands/brandscardswithimage.dart';
import 'package:t_store/common/widget/layouts/grid_layout.dart';
import 'package:t_store/common/widget/products/product_cards/product_card_vertical.dart';
import 'package:t_store/common/widget/texts/section_heading.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/constants/sizes.dart';

class TCatagoryTab extends StatelessWidget {
  const TCatagoryTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Column(
          children: [
            const TBrandShowCase(
              brandName: "Nike",
              image: TImages.clothIcon,
              productImages: [
                TImages.productImage1,
                TImages.productImage2,
                TImages.productImage3
              ],
            ),
            const SizedBox(
              height: TSizes.spaceBtwItems,
            ),
            const TSectionHeading(title: "You might like"),
            const SizedBox(
              height: TSizes.spaceBtwItems,
            ),
            TGridLayout(
                itemcount: 4,
                itemBuilder: (_, index) => const TProductCardVertical())
          ],
        ),
      ],
    );
  }
}
