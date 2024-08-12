import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/common/widget/appbar/appbar.dart';
import 'package:t_store/common/widget/brands/brandsCards.dart';
import 'package:t_store/common/widget/layouts/grid_layout.dart';
import 'package:t_store/common/widget/products/product_cards/product_card_vertical.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/constants/sizes.dart';

class BrandsWithProducts extends StatelessWidget {
  const BrandsWithProducts({super.key});

  @override
  Widget build(BuildContext context) {
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
              const Center(
                child: TBrandCards(
                  image: TImages.nikeLogo,
                  brandName: "Nike",
                  itemcount: 1,
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
                  itemBuilder: (_, index) => const TProductCardVertical())
            ],
          ),
        ),
      ),
    );
  }
}
