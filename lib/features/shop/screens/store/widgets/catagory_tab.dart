import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartshop/common/widget/brands/brandscardswithimage.dart';
import 'package:smartshop/common/widget/layouts/grid_layout.dart';
import 'package:smartshop/common/widget/products/product_cards/product_card_vertical.dart';
import 'package:smartshop/common/widget/texts/section_heading.dart';
import 'package:smartshop/features/shop/controllers/product_controller.dart';
import 'package:smartshop/features/shop/models/catagory_models.dart';
import 'package:smartshop/features/shop/screens/all_products/all_products.dart';
import 'package:smartshop/utils/constants/image_strings.dart';
import 'package:smartshop/utils/constants/sizes.dart';

class TCatagoryTab extends StatelessWidget {
  final CategoryModel category;

  const TCatagoryTab({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    final product = ProductController.instance.featuredProducts;
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Column(
          children: [
            TBrandShowCase(
              brandName: category.name,
              image: category.image,
              productImages: const [
                TImages.productImage11,
                TImages.productImage12,
                TImages.productImage13,
                TImages.productImage14,
              ],
            ),
            const SizedBox(
              height: TSizes.spaceBtwItems,
            ),
            TSectionHeading(
              title: "You might like",
              showActionButton: true,
              onPressed: () => Get.to(() => const AllProductsScreen()),
            ),
            const SizedBox(
              height: TSizes.spaceBtwItems,
            ),
            TGridLayout(
                itemcount: 4,
                itemBuilder: (_, index) => TProductCardVertical(
                      product: product[index],
                    ))
          ],
        ),
      ],
    );
  }
}
