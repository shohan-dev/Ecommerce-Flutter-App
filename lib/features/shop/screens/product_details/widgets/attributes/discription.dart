import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartshop/common/widget/custom_shape/containers/rounded_container.dart';
import 'package:smartshop/features/shop/models/product_models.dart';
import 'package:smartshop/utils/constants/colors.dart';

class TProductDiscriptions extends StatelessWidget {
  const TProductDiscriptions({
    super.key,
    required this.dark,
    required this.product,
  });

  final bool dark;
  final ProductModels product;

  @override
  Widget build(BuildContext context) {
    final double finalPrice = (double.parse(product.price.toString()) -
            (double.parse(product.price.toString()) *
                (double.parse(product.discountPercentage.toString()) / 100)))
        .toPrecision(2);
    return TRoundedContainer(
      backgroundColor: dark ? TColors.darkGrey : TColors.grey,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  "Variation",
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .apply(fontWeightDelta: 3),
                ),
                const SizedBox(
                  width: 12,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Price:",
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          product.price.toString(),
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    decoration: TextDecoration.lineThrough,
                                  ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text("\$$finalPrice",
                            style: Theme.of(context).textTheme.headlineSmall),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Stock:",
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          product.stock.toString(),
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
            Text(
              product.description,
              style: Theme.of(context).textTheme.labelSmall,
            ),
          ],
        ),
      ),
    );
  }
}
