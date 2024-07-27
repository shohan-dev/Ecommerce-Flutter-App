import 'package:flutter/material.dart';
import 'package:t_store/common/widget/Verify/t_verify_text.dart';
import 'package:t_store/common/widget/custom_shape/containers/rounded_container.dart';
// ignore: unused_import
import 'package:t_store/common/widget/images/t_circular_image.dart';
import 'package:t_store/common/widget/layouts/grid_layout.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

class TBrandCards extends StatelessWidget {
  const TBrandCards({
    super.key,
    required this.image,
    required this.brandName,
    this.totalProduct = "256 Product",
    this.itemcount = 4,
  });

  final String image;
  final String brandName;
  final String totalProduct;
  final int itemcount;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return TGridLayout(
      mainAxisExtent: 80,
      itemcount: itemcount,
      itemBuilder: (_, index) {
        return TRoundedContainer(
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
                    TVerifyText(
                      text: brandName,
                      textsize: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
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
        );
      },
    );
  }
}
