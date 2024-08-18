import 'package:flutter/material.dart';
import 'package:smartshop/common/widget/sizebox/t_sizebox_btw_items.dart';
import 'package:smartshop/features/shop/screens/product_details/widgets/bottom_add_to_card.dart';
import 'package:smartshop/features/shop/screens/product_details/widgets/product_attributes.dart';
import 'package:smartshop/features/shop/screens/product_details/widgets/product_details_image_silder.dart';
import 'package:smartshop/features/shop/screens/product_details/widgets/product_meta_data.dart';
import 'package:smartshop/features/shop/screens/product_details/widgets/rating_share.dart';
import 'package:smartshop/utils/constants/sizes.dart';
import 'package:smartshop/utils/helpers/helper_functions.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      bottomNavigationBar: const TBottomAdToCart(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Product image Slider
            const TProductImageSlider(),

            Padding(
              padding: const EdgeInsets.only(
                  left: TSizes.defaultSpace, right: TSizes.defaultSpace),
              child: Column(
                children: [
                  //Rating and Share
                  const TRatingShare(),
                  // Product Details
                  const TProductMetaData(),
                  const TSizeboxBtwItems(),
                  // Product atributes
                  TProductAttributes(
                    dark: dark,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
