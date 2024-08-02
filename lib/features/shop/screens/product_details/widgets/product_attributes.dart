import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:readmore/readmore.dart';
import 'package:t_store/common/widget/select/color_select.dart';
import 'package:t_store/common/widget/select/size_select.dart';
import 'package:t_store/common/widget/sizebox/t_sizebox_btw_items.dart';
import 'package:t_store/common/widget/texts/section_heading.dart';
import 'package:t_store/features/shop/screens/product_details/widgets/attributes/discription.dart';
import 'package:t_store/features/shop/screens/product_review/product_review.dart';

class TProductAttributes extends StatelessWidget {
  const TProductAttributes({
    super.key,
    required this.dark,
  });
  final bool dark;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Product Discription
        TProductDiscriptions(dark: dark),

        const TSizeboxBtwItems(),

        ///Color
        const TSectionHeading(
          title: "Color",
          showActionButton: false,
        ),
        const TColorSelect(
          colors: [Colors.red, Colors.green, Colors.blue],
        ),
        // Size
        const TSectionHeading(title: "Size", showActionButton: false),
        const Padding(
          padding: EdgeInsets.only(top: 5.0),
          child: TSizeSelect(size: ["S", "L", "XL"]),
        ),
        // CheckOut Button
        const TSizeboxBtwItems(),
        const TSizeboxBtwItems(),
        SizedBox(
            width: double.infinity,
            child: ElevatedButton(
                onPressed: () {}, child: const Text("Checkout"))),
        const TSizeboxBtwItems(),
        const TSizeboxBtwItems(),
        // Description
        const TSectionHeading(title: "Description", showActionButton: false),
        const TSizeboxBtwItems(),
        const ReadMoreText(
          "This is the description of this Product and details about it.This is the description of this Product and details about it.This is the description of this Product and details about it.",
          trimLines: 2,
          trimMode: TrimMode.Line,
          trimCollapsedText: "  Show more",
          trimExpandedText: "  Less",
          moreStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
          lessStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
        ),
        const TSizeboxBtwItems(),
        const Divider(),
        const TSizeboxBtwItems(),
        // Reviews
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const TSectionHeading(
              title: "Reviews(199)",
              showActionButton: false,
            ),
            IconButton(
                onPressed: () {
                  Get.to(() => const ProductReviewScreen());
                },
                icon: const Icon(Iconsax.arrow_right_3))
          ],
        ),
        const TSizeboxBtwItems(),
        const TSizeboxBtwItems(),
      ],
    );
  }
}
