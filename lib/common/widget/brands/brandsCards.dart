import 'package:flutter/material.dart';
import 'package:smartshop/common/widget/custom_shape/containers/rounded_container.dart';
import 'package:smartshop/common/widget/layouts/grid_layout.dart';
import 'package:smartshop/utils/constants/colors.dart';
import 'package:smartshop/utils/constants/sizes.dart';
import 'package:smartshop/utils/helpers/helper_functions.dart';

class TBrandCards extends StatelessWidget {
  const TBrandCards({
    super.key,
    required this.image,
    required this.brandName,
    this.totalProduct = "256 Product",
    this.itemcount = 4,
    this.onPressed,
  });

  final String image;
  final String brandName;
  final String totalProduct;
  final int itemcount;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return TGridLayout(
      mainAxisExtent: 80,
      itemcount: itemcount,
      itemBuilder: (_, index) {
        return GestureDetector(
          onTap: onPressed,
          child: TRoundedContainer(
            padding: const EdgeInsets.all(TSizes.sm),
            backgroundColor: Colors.transparent,
            showBorder: true,
            child: Row(
              children: [
                Image(
                  height: 56,
                  width: 56,
                  image: AssetImage(image),
                  color: dark ? TColors.white : TColors.dark,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Text(
                          brandName,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow
                              .ellipsis, // Adds '...' at the end of the text if it overflows
                          maxLines: 1, // Limits the text to a single line
                        ),
                      ),
                      Text(
                        totalProduct,
                        style: const TextStyle(
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
    );
  }
}
