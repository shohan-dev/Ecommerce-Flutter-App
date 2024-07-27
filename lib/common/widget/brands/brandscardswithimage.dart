import 'package:flutter/material.dart';
import 'package:t_store/common/widget/Verify/t_verify_text.dart';
import 'package:t_store/common/widget/custom_shape/containers/rounded_container.dart';
import 'package:t_store/common/widget/images/t_circular_image.dart';
import 'package:t_store/common/widget/layouts/grid_layout.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

class TBrandShowCase extends StatelessWidget {
  const TBrandShowCase({
    super.key,
    required this.image,
    required this.brandName,
    this.totalProduct = "256 Product",
    required this.productImages,
  });

  final String image;
  final List<String> productImages;
  final String brandName;
  final String totalProduct;

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      padding: const EdgeInsets.all(TSizes.sm),
      backgroundColor: Colors.transparent,
      showBorder: true,
      child: Column(
        children: [
          Row(
            children: [
              TCircularImage(
                image: image,
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
          // Horizontal layout for images
          Container(
            height: 120, // Adjust the height to fit images
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: productImages
                  .map(
                    (image) => BrandImages(image, context),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

Widget BrandImages(String image, context) {
  return Expanded(
    child: TRoundedContainer(
      height: 100,
      padding: EdgeInsets.all(TSizes.md),
      margin: EdgeInsets.only(right: TSizes.sm),
      backgroundColor: THelperFunctions.isDarkMode(context)
          ? TColors.darkGrey
          : TColors.light,
      child: Image(
        image: AssetImage(image),
        fit: BoxFit.cover,
      ),
    ),
  );
}
