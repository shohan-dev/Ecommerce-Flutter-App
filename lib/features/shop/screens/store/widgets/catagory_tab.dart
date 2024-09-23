import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartshop/common/widget/brands/brandscardswithimage.dart';
import 'package:smartshop/common/widget/layouts/grid_layout.dart';
import 'package:smartshop/common/widget/products/product_cards/product_card_vertical.dart';
import 'package:smartshop/common/widget/texts/section_heading.dart';
import 'package:smartshop/features/shop/controllers/product_controller.dart';
import 'package:smartshop/features/shop/models/catagory_models.dart';
import 'package:smartshop/features/shop/screens/all_products/all_products.dart';
import 'package:smartshop/utils/constants/sizes.dart';

class TCatagoryTab extends StatelessWidget {
  final CategoryModel category;

  const TCatagoryTab({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    // Fetch products for the given category when the widget is built
    final ProductController productController = Get.find();
    productController.fetchCategoryProduct(category.name);

    return Obx(() {
      final products = productController.categoryProducts;

      print("this is the product $products");

      return ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Column(
            children: [
              TBrandShowCase(
                brandName: category.name,
                image: category.image,
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
              // Check if products are available
              if (products.isEmpty)
                const Center(child: Text("No products found."))
              else
                TGridLayout(
                  itemcount: products.length,
                  itemBuilder: (_, index) {
                    return TProductCardVertical(
                      product: products[index],
                    );
                  },
                ),
            ],
          ),
        ],
      );
    });
  }
}
