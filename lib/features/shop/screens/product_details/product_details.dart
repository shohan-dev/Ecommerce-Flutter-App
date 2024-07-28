import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/common/widget/appbar/appbar.dart';
import 'package:t_store/common/widget/custom_shape/containers/rounded_container.dart';
import 'package:t_store/common/widget/custom_shape/curved_edges/curved_edges_widgets.dart';
import 'package:t_store/common/widget/images/t_round_images.dart';
import 'package:t_store/common/widget/sizebox/t_sizebox_btw_items.dart';
import 'package:t_store/features/shop/screens/product_details/widgets/product_attributes.dart';
import 'package:t_store/features/shop/screens/product_details/widgets/product_details_image_silder.dart';
import 'package:t_store/features/shop/screens/product_details/widgets/product_meta_data.dart';
import 'package:t_store/features/shop/screens/product_details/widgets/rating_share.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Product image Slider
            const TProductImageSlider(),

            Padding(
              padding: const EdgeInsets.only(left: TSizes.defaultSpace),
              child: Column(
                children: [
                  //Rating and Share
                  const TRatingShare(),
                  // Product Details
                  const TProductMetaData(),
                  TSizeboxBtwItems(),
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
