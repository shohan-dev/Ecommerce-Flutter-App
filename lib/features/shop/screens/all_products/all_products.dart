import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:smartshop/common/widget/appbar/appbar.dart';
import 'package:smartshop/common/widget/layouts/grid_layout.dart';
import 'package:smartshop/common/widget/products/product_cards/product_card_vertical.dart';
import 'package:smartshop/features/shop/controllers/product_controller.dart';
import 'package:smartshop/utils/constants/sizes.dart';

class AllProductsScreen extends StatelessWidget {
  const AllProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ProductController.instance.featuredProducts;
    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: Text("All Products",
            style: Theme.of(context).textTheme.headlineSmall),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              DropdownButtonFormField(
                decoration:
                    const InputDecoration(prefixIcon: Icon(Iconsax.sort)),
                items: [
                  "Name",
                  "Higher Price",
                  "Lower Price",
                  "Sale",
                  "Newest",
                  "Popularity"
                ].map((String value) {
                  return DropdownMenuItem(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? value) {},
              ),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),
              // Product List
              TGridLayout(
                  itemcount: 10,
                  itemBuilder: (_, index) => TProductCardVertical(
                        product: product[index],
                      ))
            ],
          ),
        ),
      ),
    );
  }
}
