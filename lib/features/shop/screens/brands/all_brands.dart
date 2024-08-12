import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/common/widget/appbar/appbar.dart';
import 'package:t_store/common/widget/brands/brandsCards.dart';
import 'package:t_store/common/widget/texts/section_heading.dart';
import 'package:t_store/features/shop/screens/brands_with_products/brands_with_products.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/constants/sizes.dart';

class AllBrandsScreen extends StatelessWidget {
  const AllBrandsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: Text("All Brands",
            style: Theme.of(context).textTheme.headlineSmall),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              // Heading
              const TSectionHeading(
                title: "Brands",
                showActionButton: false,
              ),
              // Brands List
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              TBrandCards(
                itemcount: 10,
                image: TImages.nikeLogo,
                brandName: "Nike",
                onPressed: () => Get.to(() => const BrandsWithProducts()),
              )
            ],
          ),
        ),
      ),
    );
  }
}
