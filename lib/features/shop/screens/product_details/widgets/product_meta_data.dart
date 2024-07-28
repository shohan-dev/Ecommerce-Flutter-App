import 'package:flutter/material.dart';
import 'package:t_store/common/widget/Verify/t_verify_text.dart';
import 'package:t_store/common/widget/custom_shape/containers/rounded_container.dart';
import 'package:t_store/common/widget/images/t_circular_image.dart';
import 'package:t_store/common/widget/sizebox/t_sizebox_btw_items.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

class TProductMetaData extends StatelessWidget {
  const TProductMetaData({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            TRoundedContainer(
              radius: TSizes.sm,
              backgroundColor: TColors.secondary.withOpacity(0.8),
              padding: const EdgeInsets.symmetric(
                  horizontal: TSizes.sm, vertical: TSizes.xs - 2),
              child: const Text(
                "25%",
                style: TextStyle(color: TColors.black),
              ), // Discount
            ),
            const SizedBox(
              width: 10,
            ),
            Opacity(
              opacity: 0.8,
              child: Text(
                "\$250",
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      decoration: TextDecoration.lineThrough,
                    ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              "\$175",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
        const SizedBox(
          height: 7,
        ),
        // details
        Text(
          "Green Nike Sports Shirt",
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(
          height: 7,
        ),
        Row(
          children: [
            Text(
              "Status",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(
              width: 7,
            ),
            Text(
              "in Stock",
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ],
        ),
        const SizedBox(
          width: 2,
        ),
        const TSizeboxBtwItems(),
        Row(
          children: [
            Image(
                height: 27,
                width: 27,
                color: dark ? TColors.white : TColors.black,
                image: const AssetImage(TImages.nikeLogo)),
            const SizedBox(
              width: 3,
            ),
            const TVerifyText(
              textsize: TextStyle(fontSize: 15),
              text: 'Nike',
            ),
          ],
        ),
      ],
    );
  }
}
