import 'package:flutter/material.dart';
import 'package:smartshop/utils/constants/sizes.dart';

class TBillingAmountSectionSingle extends StatelessWidget {
  const TBillingAmountSectionSingle({
    super.key,
    required this.taxFee,
    required this.shoppingFee,
    required this.totalPrices,
    required this.price,
  });

  final double taxFee, shoppingFee, totalPrices, price;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Subtotal",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              "\$${price.toString()}",
              style: Theme.of(context).textTheme.bodyLarge,
            )
          ],
        ),
        const SizedBox(
          height: TSizes.spaceBtwItems / 2,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Shipping Fee",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              "\$${shoppingFee.toString()}",
              style: Theme.of(context).textTheme.bodyLarge,
            )
          ],
        ),
        const SizedBox(
          height: TSizes.spaceBtwItems / 2,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Tax Fee",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              "\$${taxFee.toString()}",
              style: Theme.of(context).textTheme.bodyLarge,
            )
          ],
        ),
        const SizedBox(
          height: TSizes.spaceBtwItems,
        ),
        const Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Order Total",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              "\$${totalPrices.toString()}",
              style: Theme.of(context).textTheme.titleSmall,
            )
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems / 5),
      ],
    );
  }
}
