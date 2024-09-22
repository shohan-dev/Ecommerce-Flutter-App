import 'package:flutter/material.dart';
import 'package:smartshop/common/widget/appbar/appbar.dart';
import 'package:smartshop/common/widget/texts/section_heading.dart';
import 'package:smartshop/features/shop/controllers/brand_controller.dart';
import 'package:smartshop/features/shop/screens/brands/widgets/card.dart';
import 'package:smartshop/utils/constants/sizes.dart';

class AllBrandsScreen extends StatelessWidget {
  const AllBrandsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final allBrands = BrandController.instance.brands;
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
                title: "All Brands",
                showActionButton: false,
              ),
              // Brands List
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              TAllBrandCards(
                allBrands: allBrands,
              )
            ],
          ),
        ),
      ),
    );
  }
}
