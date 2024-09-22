import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartshop/common/widget/Verify/t_verify_text.dart';
import 'package:smartshop/common/widget/custom_shape/containers/rounded_container.dart';
import 'package:smartshop/common/widget/images/t_circular_image.dart';
import 'package:smartshop/common/widget/sizebox/t_sizebox_btw_items.dart';
import 'package:smartshop/features/shop/models/brand_models.dart';
import 'package:smartshop/utils/constants/colors.dart';
import 'package:smartshop/utils/constants/sizes.dart';
import 'package:smartshop/utils/helpers/helper_functions.dart';

var brandimage = ''.obs;

class TProductMetaData extends StatelessWidget {
  const TProductMetaData({
    super.key,
    required this.discount,
    required this.price,
    required this.title,
    required this.brand,
    required this.availabilityStatus,
  });

  final String discount, price, title, brand, availabilityStatus;

  @override
  Widget build(BuildContext context) {
    THelperFunctions.isDarkMode(context);
    brandImageFetchOnline();
    final double finalPrice = (double.parse(price) -
            (double.parse(price) * (double.parse(discount) / 100)))
        .toPrecision(2);

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
              child: Text(
                "$discount%",
                style: const TextStyle(color: TColors.black),
              ), // Discount
            ),
            const SizedBox(
              width: 10,
            ),
            Opacity(
              opacity: 0.8,
              child: Text(
                "\$$price",
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      decoration: TextDecoration.lineThrough,
                    ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              "\$${finalPrice.toString()}",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
        const SizedBox(
          height: 7,
        ),
        // details
        Text(
          title,
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
              availabilityStatus,
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
            Obx(() => TCircularImage(
                  image: brandimage.value,
                  isNetworkImage: true,
                  height: 20,
                  width: 20,
                )),
            const SizedBox(
              width: 3,
            ),
            TVerifyText(
              textsize: const TextStyle(fontSize: 15),
              text: brand,
            ),
          ],
        ),
      ],
    );
  }

  // Brand Image Fetch by Name

  Future<void> brandImageFetchOnline() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('Brands')
        .where(
          'name',
          isEqualTo: brand,
        )
        .get();
    final list = snapshot.docs.map((doc) => BrandModels.fromMap(doc)).toList();

    brandimage.value = list[0].image;
  }
}
