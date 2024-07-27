import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/common/widget/Verify/t_verify_text.dart';
import 'package:t_store/common/widget/appbar/appbar.dart';
import 'package:t_store/common/widget/custom_shape/containers/rounded_container.dart';
import 'package:t_store/common/widget/custom_shape/containers/searchbar_containers.dart';
import 'package:t_store/common/widget/custom_shape/curved_edges/curved_edges_widgets.dart';
import 'package:t_store/common/widget/images/t_circular_image.dart';
import 'package:t_store/common/widget/layouts/grid_layout.dart';
import 'package:t_store/common/widget/products/cart/cart_menu_icon.dart';
import 'package:t_store/common/widget/texts/section_heading.dart';
import 'package:t_store/features/shop/screens/home/widgets/home_appbar.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
          headerSliverBuilder: (_, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                pinned: true,
                floating: true,
                backgroundColor: THelperFunctions.isDarkMode(context)
                    ? TColors.black
                    : TColors.white,
                expandedHeight: 440,
                flexibleSpace: Padding(
                  padding: const EdgeInsets.all(TSizes.defaultSpace),
                  child: ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      const SizedBox(
                        height: TSizes.spaceBtwItems,
                      ),
                      const TSearchBarContainer(text: "Search in Store"),
                      const SizedBox(
                        height: TSizes.spaceBtwSections,
                      ),
                      const TSectionHeading(
                        title: "Featured Brands ",
                      ),
                      // Container with image and text
                      TGridLayout(
                          mainAxisExtent: 80,
                          itemcount: 4,
                          itemBuilder: (_, index) {
                            return const TRoundedContainer(
                              padding: EdgeInsets.all(TSizes.sm),
                              backgroundColor: Colors.transparent,
                              showBorder: true,
                              child: Row(
                                children: [
                                  Flexible(
                                    child: TCircularImage(
                                      image: TImages.clothIcon,
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TVerifyText(
                                          text: "Nike",
                                          textsize: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          "256 Product",
                                          style: TextStyle(
                                              overflow: TextOverflow.ellipsis),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            );
                          })
                    ],
                  ),
                ),
              )
            ];
          },
          body: const Text("data")),
    );
  }
}
