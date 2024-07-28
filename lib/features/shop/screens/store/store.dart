import 'package:flutter/material.dart';
import 'package:t_store/common/widget/appbar/tabbar.dart';
import 'package:t_store/common/widget/custom_shape/containers/searchbar_containers.dart';
import 'package:t_store/common/widget/texts/section_heading.dart';
import 'package:t_store/common/widget/brands/brandsCards.dart';
import 'package:t_store/features/shop/screens/store/widgets/catagory_tab.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

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
                flexibleSpace: const FlexibleSpaceBar(
                  background: Padding(
                    padding: EdgeInsets.all(TSizes.defaultSpace),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: TSizes.spaceBtwItems,
                        ),
                        TSearchBarContainer(text: "Search in Store"),
                        SizedBox(
                          height: TSizes.spaceBtwSections,
                        ),
                        TSectionHeading(
                          title: "Featured Brands",
                        ),
                        TBrandCards(
                          brandName: "Nike",
                          image: TImages.nikeLogo,
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
