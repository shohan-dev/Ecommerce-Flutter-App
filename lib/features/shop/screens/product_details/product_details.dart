import 'package:flutter/material.dart';
import 'package:smartshop/common/widget/sizebox/t_sizebox_btw_items.dart';
import 'package:smartshop/features/shop/models/product_models.dart';
import 'package:smartshop/features/shop/screens/product_details/widgets/bottom_add_to_card.dart';
import 'package:smartshop/features/shop/screens/product_details/widgets/product_attributes.dart';
import 'package:smartshop/features/shop/screens/product_details/widgets/product_details_image_silder.dart';
import 'package:smartshop/features/shop/screens/product_details/widgets/product_meta_data.dart';
import 'package:smartshop/features/shop/screens/product_details/widgets/rating_share.dart';
import 'package:smartshop/utils/constants/sizes.dart';
import 'package:smartshop/utils/helpers/helper_functions.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key, required this.product});

  final ProductModels product;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    double avgRating = AvgRating();

    return Scaffold(
      bottomNavigationBar:  TBottomAdToCart(product: product),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Product image Slider
            TProductImageSlider(product: product),

            Padding(
              padding: const EdgeInsets.only(
                  left: TSizes.defaultSpace, right: TSizes.defaultSpace),
              child: Column(
                children: [
                  //Rating and Share
                  TRatingShare(avgRating, product.reviews!.length),
                  // Product Details
                  TProductMetaData(
                    title: product.title,
                    availabilityStatus: product.availabilityStatus,
                    brand: product.brand,
                    discount: product.discountPercentage.toString(),
                    price: product.price.toString(),
                  ),
                  const TSizeboxBtwItems(),
                  // Product atributes
                  TProductAttributes(
                    dark: dark,
                    product: product,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  double AvgRating() {
    final List<int?> ratings = product.reviews!.map((e) => e.rating).toList();
    final int? sum = ratings.reduce((value, element) => value! + element!);
    final double avgRating = sum! / ratings.length;
    return avgRating;
  }
}
