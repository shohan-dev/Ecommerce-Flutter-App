import 'package:flutter/material.dart';
import 'package:smartshop/common/widget/texts/section_heading.dart';
import 'package:smartshop/utils/constants/sizes.dart';

class TAddressSectionSingle extends StatelessWidget {
  const TAddressSectionSingle({
    super.key
  });


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TSectionHeading(
            title: "Shipping Address", buttonTitle: "Change", onPressed: () {}),
        Text(
          "John Doe",
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(
          height: TSizes.spaceBtwItems / 2,
        ),
        Row(
          children: [
            const Icon(
              Icons.phone,
              color: Colors.grey,
              size: 16,
            ),
            const SizedBox(
              width: TSizes.spaceBtwItems,
            ),
            Text(
              "+1 123 456 7890",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
        const SizedBox(
          height: TSizes.spaceBtwItems / 2,
        ),
        Row(
          children: [
            const Icon(
              Icons.location_history,
              color: Colors.grey,
              size: 16,
            ),
            const SizedBox(
              width: TSizes.spaceBtwItems,
            ),
            Text(
              "1234 Main Street, New York, NY 10001",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ],
    );
  }
}
