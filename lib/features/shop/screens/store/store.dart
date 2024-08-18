import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartshop/common/widget/appbar/tabbar.dart';
import 'package:smartshop/common/widget/custom_shape/containers/searchbar_containers.dart';
import 'package:smartshop/common/widget/texts/section_heading.dart';
import 'package:smartshop/common/widget/brands/brandsCards.dart';
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
    return Scaffold(
      body: DefaultTabController(
        length: 5,
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
                        const SizedBox(
                          height: TSizes.spaceBtwItems * 3,
                        ),
                        const TSearchBarContainer(text: "Search in Store"),
                        const SizedBox(
                          height: TSizes.spaceBtwSections,
                        ),
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
                bottom: const PreferredSize(
                  preferredSize: Size.fromHeight(48.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: TTabBar(
                      tabs: [
                        Tab(child: Text("Sports")),
                        Tab(child: Text("Furniture")),
                        Tab(child: Text("Electronics")),
                        Tab(child: Text("Clothes")),
                        Tab(child: Text("Cosmetics")),
                      ],
                    ),
                  ),
                ),
              ),
            ];
          },
          body: const TabBarView(
            children: [
              TCatagoryTab(),
              TCatagoryTab(),
              TCatagoryTab(),
              TCatagoryTab(),
              TCatagoryTab(),
            ],
          ),
        ),
      ),
    );
  }
}
