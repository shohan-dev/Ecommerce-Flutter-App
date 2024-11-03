import 'package:flutter/material.dart';
import 'package:smartshop/common/widget/Verify/t_verify_text.dart';
import 'package:smartshop/common/widget/images/t_round_images.dart';
import 'package:smartshop/common/widget/texts/product_title.dart';
import 'package:smartshop/features/shop/models/product_models.dart';
import 'package:smartshop/utils/constants/colors.dart';
import 'package:smartshop/utils/constants/sizes.dart';
import 'package:smartshop/utils/helpers/helper_functions.dart';

class CartItemList_section extends StatelessWidget {
  const CartItemList_section({
    super.key,
    required this.product,
    required this.selectedColor,
    required this.selectedSize,
  });

  final ProductModels product;
  final String selectedColor, selectedSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // images
        TRoundImage(
          imageUrl: product.thumbnail,
          isNetworkImage: true,
          width: 150,
          height: 150,
          padding: const EdgeInsets.all(TSizes.sm),
          backgroundColor: THelperFunctions.isDarkMode(context)
              ? TColors.darkGrey
              : TColors.light,
        ),
        const SizedBox(
          width: TSizes.spaceBtwItems * 2,
        ),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TVerifyText(text: product.brand),
              Flexible(
                child: TProductTitle(
                  title: product.title,
                  maxLines: 1,
                ),
              ),
              // text
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: "Color: ",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    TextSpan(
                      text: selectedColor,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    TextSpan(
                      text: "  Size: ",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    TextSpan(
                      text: selectedSize,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
