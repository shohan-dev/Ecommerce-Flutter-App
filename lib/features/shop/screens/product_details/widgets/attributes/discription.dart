import 'package:flutter/material.dart';
import 'package:smartshop/common/widget/custom_shape/containers/rounded_container.dart';
import 'package:smartshop/utils/constants/colors.dart';

class TProductDiscriptions extends StatelessWidget {
  const TProductDiscriptions({
    super.key,
    required this.dark,
  });

  final bool dark;

  @override
  Widget build(BuildContext context) {
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
                          "\$25",
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    decoration: TextDecoration.lineThrough,
                                  ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text("\$20",
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
                          "In Stock",
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
            Text(
              "This is the Description of the Product and it can go up to max 4 lines",
              style: Theme.of(context).textTheme.labelSmall,
            ),
          ],
        ),
      ),
    );
  }
}
