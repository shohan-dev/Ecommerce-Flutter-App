import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartshop/common/widget/custom_shape/containers/primary_header_container.dart';
import 'package:smartshop/common/widget/layouts/grid_layout.dart';
import 'package:smartshop/common/widget/products/product_cards/product_card_vertical.dart';
import 'package:smartshop/common/widget/texts/section_heading.dart';
import 'package:smartshop/features/shop/controllers/product_controller.dart';
import 'package:smartshop/features/shop/screens/home/widgets/home_appbar.dart';
import 'package:smartshop/features/shop/screens/home/widgets/home_catagories.dart';
import 'package:smartshop/common/widget/slide_bar/promo_slider.dart';
import 'package:smartshop/features/shop/screens/home/widgets/home_searchbar.dart';
import 'package:smartshop/features/shop/screens/search/search.dart';
import 'package:smartshop/state_setup_controller.dart';
import 'package:smartshop/utils/constants/colors.dart';
import 'package:smartshop/utils/constants/sizes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    setupController();
    final controller = ProductController.instance;

    // ignore: prefer_const_constructors
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const TPrimaryHeaderContainer(
                child: Column(
              children: [
                THomeAppbar(), // Appbar
                SizedBox(
                  height: TSizes.spaceBtwSections,
                ),
                THomeSearchBar(
                  text: "Search", // SearchBar
                ),

                //Catagory Section
                SizedBox(
                  height: TSizes.spaceBtwSections,
                ),
                Padding(
                  padding: EdgeInsets.only(left: TSizes.defaultSpace),
                  child: TSectionHeading(
                    title: 'Popular Catagory',
                    showActionButton: false,
                    textcolor: TColors.white,
                  ),
                ),
                SizedBox(
                  height: TSizes.spaceBtwSections / 2,
                ),

                /// Catagory Section image section

                THomeCategories(),
              ],
            )),
            // Scroll section

            const TPromoSlider(),

            // Popular Products section
            const SizedBox(
              height: TSizes.spaceBtwSections / 5,
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: TSizes.spaceBtwItems, right: TSizes.spaceBtwItems),
              child: TSectionHeading(
                title: "Popular Products",
                showActionButton: true,
                onPressed: () {
                  Get.to(() => SearchProductScreen());
                },
              ),
            ),
            const SizedBox(
              height: TSizes.spaceBtwSections,
            ),

            // Product list section
            Obx(
              () => TGridLayout(
                  itemcount: controller.featuredProducts.length,
                  itemBuilder: (_, index) => TProductCardVertical(
                      product: controller.featuredProducts[index])),
            )
          ],
        ),
      ),
    );
  }
}
