import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartshop/common/widget/custom_shape/containers/rounded_container.dart';
import 'package:smartshop/common/widget/images/t_circular_image.dart';
import 'package:smartshop/common/widget/layouts/grid_layout.dart';
import 'package:smartshop/features/shop/models/brand_models.dart';
import 'package:smartshop/features/shop/screens/brands_with_products/brands_with_products.dart';
import 'package:smartshop/utils/constants/sizes.dart';
import 'package:smartshop/utils/helpers/helper_functions.dart';

class TAllBrandCards extends StatelessWidget {
  final RxList<BrandModels> allBrands;

  const TAllBrandCards({
    super.key,
    required this.allBrands,
  });

  @override
  Widget build(BuildContext context) {
    THelperFunctions.isDarkMode(context);
    return TGridLayout(
      mainAxisExtent: 80,
      itemcount: allBrands.length,
      itemBuilder: (_, index) {
        return GestureDetector(
          onTap: () {
            Get.to(() => BrandsWithProducts(
                  brand: allBrands[index],
                ));
          },
          child: TRoundedContainer(
            padding: const EdgeInsets.all(TSizes.sm),
            backgroundColor: Colors.transparent,
            showBorder: true,
            child: Row(
              children: [
                TCircularImage(
                  image: allBrands[index].image,
                  isNetworkImage: true,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Text(
                          allBrands[index].name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow
                              .ellipsis, // Adds '...' at the end of the text if it overflows
                          maxLines: 1, // Limits the text to a single line
                        ),
                      ),
                      // Text(
                      //   totalProduct,
                      //   style: const TextStyle(
                      //     overflow: TextOverflow.ellipsis,
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
