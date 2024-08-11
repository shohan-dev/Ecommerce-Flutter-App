import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/common/widget/custom_shape/containers/primary_header_container.dart';
import 'package:t_store/common/widget/custom_shape/containers/searchbar_containers.dart';
import 'package:t_store/common/widget/layouts/grid_layout.dart';
import 'package:t_store/common/widget/products/product_cards/product_card_vertical.dart';
import 'package:t_store/common/widget/texts/section_heading.dart';
import 'package:t_store/features/shop/screens/home/widgets/home_appbar.dart';
import 'package:t_store/features/shop/screens/home/widgets/home_catagories.dart';
import 'package:t_store/common/widget/slide_bar/promo_slider.dart';
import 'package:t_store/features/shop/screens/sub_category/sub_categories.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/constants/sizes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                TSearchBarContainer(
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
            const TPromoSlider(
              banner: [
                TImages.banner1,
                TImages.banner2,
                TImages.banner3,
                TImages.banner4,
              ],
            ),
            // Popular Products section
            const SizedBox(
              height: TSizes.spaceBtwSections / 5,
            ),
            const Padding(
              padding: EdgeInsets.only(
                  left: TSizes.spaceBtwItems, right: TSizes.spaceBtwItems),
              child: TSectionHeading(
                title: "Popular Products",
              ),
            ),
            const SizedBox(
              height: TSizes.spaceBtwSections,
            ),

            // Product list section
            TGridLayout(
                itemcount: 5,
                itemBuilder: (_, index) => const TProductCardVertical())
          ],
        ),
      ),
    );
  }
}
