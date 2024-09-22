import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:readmore/readmore.dart';
import 'package:smartshop/common/widget/select/color_select.dart';
import 'package:smartshop/common/widget/select/size_select.dart';
import 'package:smartshop/common/widget/sizebox/t_sizebox_btw_items.dart';
import 'package:smartshop/common/widget/texts/section_heading.dart';
import 'package:smartshop/features/shop/controllers/product_details.dart';
import 'package:smartshop/features/shop/models/product_models.dart';
import 'package:smartshop/features/shop/screens/product_details/widgets/attributes/discription.dart';
import 'package:smartshop/features/shop/screens/product_review/product_review.dart';

class TProductAttributes extends StatelessWidget {
  const TProductAttributes({
    super.key,
    required this.dark,
    required this.product,
  });
  final bool dark;
  final ProductModels product;
  @override
  Widget build(BuildContext context) {
    final selectedColorobs = Get.put(ProductDetailsController()).selectedColor;
    final selectedSizeobs = Get.put(ProductDetailsController()).selectedSize;

    return Column(
      children: [
        // Product Discription
        TProductDiscriptions(dark: dark, product: product),

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
                onPressed: () {
                  print(selectedColorobs);
                  print(selectedSizeobs);
                },
                child: const Text("Checkout"))),
        const TSizeboxBtwItems(),
        const TSizeboxBtwItems(),
        // Description
        const TSectionHeading(title: "Description", showActionButton: false),
        const TSizeboxBtwItems(),
        ReadMoreText(
          product.description,
          trimLines: 2,
          trimMode: TrimMode.Line,
          trimCollapsedText: "  Show more",
          trimExpandedText: "  Less",
          moreStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
          lessStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
        ),
        const TSizeboxBtwItems(),
        const Divider(),
        const TSizeboxBtwItems(),
        // Reviews
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TSectionHeading(
              title: "Reviews(${product.reviews?.length.toString()})",
              showActionButton: false,
            ),
            IconButton(
                onPressed: () {
                  Get.to(() =>  ProductReviewScreen(product: product));
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
