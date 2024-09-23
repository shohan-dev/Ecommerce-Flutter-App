import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartshop/common/widget/custom_shape/containers/rounded_container.dart';
import 'package:smartshop/common/widget/effect/catagories_shimmer_effect.dart';
import 'package:smartshop/common/widget/images/t_circular_image.dart';
import 'package:smartshop/common/widget/layouts/grid_layout.dart';
import 'package:smartshop/features/shop/screens/brands/widgets/brands_with_products/brands_with_products.dart';
import 'package:smartshop/utils/constants/sizes.dart';
import 'package:smartshop/utils/helpers/helper_functions.dart';

class Popularbrands extends StatelessWidget {
  const Popularbrands({
    super.key,
    required this.listbrands,
    required this.isLoading,
  });

  final RxList listbrands;
  final RxBool isLoading;
  @override
  Widget build(BuildContext context) {
    THelperFunctions.isDarkMode(context);
    return Obx(
      () => TGridLayout(
        mainAxisExtent: 80,
        itemcount: listbrands.length,
        itemBuilder: (_, index) {
          return GestureDetector(
            onTap: () {
              Get.to(() => BrandsWithProducts(brandsData: listbrands[index]));
            },
            child: TRoundedContainer(
              padding: const EdgeInsets.all(TSizes.sm),
              backgroundColor: Colors.transparent,
              showBorder: true,
              child: Row(
                children: [
                  if (isLoading.value)
                    const TShimmerEffect(width: 50, height: 50)
                  else
                    TCircularImage(
                        image: listbrands[index].image, isNetworkImage: true),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Text(
                            listbrands[index].name,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow
                                .ellipsis, // Adds '...' at the end of the text if it overflows
                            maxLines: 1, // Limits the text to a single line
                          ),
                        ),
                        const Text(
                          "240 Products",
                          style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
