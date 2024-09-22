import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:smartshop/common/widget/appbar/appbar.dart';
import 'package:smartshop/common/widget/brands/brandscardswithimage.dart';
import 'package:smartshop/common/widget/layouts/grid_layout.dart';
import 'package:smartshop/common/widget/products/product_cards/product_card_vertical.dart';
import 'package:smartshop/features/shop/controllers/product_controller.dart';
import 'package:smartshop/features/shop/models/brand_models.dart';
import 'package:smartshop/utils/constants/sizes.dart';

class BrandsWithProducts extends StatelessWidget {
  final BrandModels brand;
  const BrandsWithProducts({super.key, required this.brand});

  @override
  Widget build(BuildContext context) {
    final product = ProductController.instance.featuredProducts;

    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: Text("Brand Product Search",
            style: Theme.of(context).textTheme.headlineSmall),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              Center(
                child: TBrandShowCase(
                  image: brand.image,
                  brandName: brand.name,
                  
                  
                  
                ),
              ),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  prefixIcon: const Icon(Iconsax.sort),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                items: [
                  "Name",
                  "Higher Price",
                  "Lower Price",
                  "Sale",
                  "Newest",
                  "Popularity"
                ].map((String value) {
                  return DropdownMenuItem<String>(
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
