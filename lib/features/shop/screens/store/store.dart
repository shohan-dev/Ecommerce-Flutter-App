import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartshop/common/widget/appbar/tabbar.dart';
import 'package:smartshop/common/widget/custom_shape/containers/searchbar_containers.dart';
import 'package:smartshop/common/widget/texts/section_heading.dart';
import 'package:smartshop/common/widget/brands/brandsCards.dart';
import 'package:smartshop/features/shop/controllers/brand_controller.dart';
import 'package:smartshop/features/shop/controllers/category_controller.dart';
import 'package:smartshop/features/shop/screens/brands/all_brands.dart';
import 'package:smartshop/features/shop/screens/brands_with_products/brands_with_products.dart';
import 'package:smartshop/features/shop/screens/store/widgets/catagory_tab.dart';
import 'package:smartshop/utils/constants/colors.dart';
import 'package:smartshop/utils/constants/image_strings.dart';
import 'package:smartshop/utils/constants/sizes.dart';
import 'package:smartshop/utils/helpers/helper_functions.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = CategoryController.instance.allCategories;
    final brandController = Get.put(BrandController());

    return Scaffold(
      body: DefaultTabController(
        length: categories.length,
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                pinned: true,
                floating: true,
                backgroundColor: THelperFunctions.isDarkMode(context)
                    ? TColors.black
                    : TColors.white,
                expandedHeight: 440,
                flexibleSpace: FlexibleSpaceBar(
                  background: Padding(
                    padding: const EdgeInsets.all(TSizes.defaultSpace),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: TSizes.spaceBtwItems * 3),
                        const TSearchBarContainer(text: "Search in Store"),
                        const SizedBox(height: TSizes.spaceBtwSections),
                        TSectionHeading(
                          title: "Featured Brands",
                          showActionButton: true,
                          onPressed: () =>
                              Get.to(() => const AllBrandsScreen()),
                        ),
                        TBrandCards(
                          brandName: "Nike",
                          image: TImages.nikeLogo,
                          onPressed: () =>
                              Get.to(() => const BrandsWithProducts()),
                        ),
                      ],
                    ),
                  ),
                ),
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(48.0),
                  child: TTabBar(
                    tabs: categories
                        .map((category) => Tab(text: category.name))
                        .toList(),
                  ),
                ),
              ),
            ];
          },
          body: TabBarView(
            children: categories
                .map((category) => TCatagoryTab(category: category))
                .toList(),
          ),
        ),
      ),
    );
  }
}
