import 'package:flutter/material.dart';
import 'package:t_store/common/widget/custom_shape/containers/primary_header_container.dart';
import 'package:t_store/common/widget/custom_shape/containers/searchbar_containers.dart';
import 'package:t_store/common/widget/texts/section_heading.dart';
import 'package:t_store/features/shop/screens/home/widgets/home_appbar.dart';
import 'package:t_store/features/shop/screens/home/widgets/home_catagories.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            TPrimaryHeaderContainer(
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

                THomeCategories()
              ],
            ))
          ],
        ),
      ),
    );
  }
}
