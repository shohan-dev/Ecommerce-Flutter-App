import 'package:flutter/material.dart';
import 'package:smartshop/common/widget/Verify/t_verify_text.dart';
import 'package:smartshop/common/widget/images/t_round_images.dart';
import 'package:smartshop/common/widget/texts/product_title.dart';
import 'package:smartshop/utils/constants/colors.dart';
import 'package:smartshop/utils/constants/sizes.dart';
import 'package:smartshop/utils/helpers/helper_functions.dart';

class TCartItems extends StatelessWidget {
  const TCartItems({
    super.key,
    required this.cartList,
  });

  final List<Map<String, dynamic>> cartList;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // images
        TRoundImage(
          isNetworkImage: true,
          imageUrl: cartList[0]['image'][0],
          width: 60,
          height: 60,
          padding: const EdgeInsets.all(TSizes.sm),
          backgroundColor: THelperFunctions.isDarkMode(context)
              ? TColors.darkGrey
              : TColors.light,
        ),
        const SizedBox(
          width: TSizes.spaceBtwItems,
        ),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TVerifyText(text: cartList[0]['brand']),
              Flexible(
                child: TProductTitle(
                  title: cartList[0]['name'],
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
                      text: cartList[0]['color'],
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    TextSpan(
                      text: "  Size: ",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    TextSpan(
                      text: cartList[0]['size'],
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
