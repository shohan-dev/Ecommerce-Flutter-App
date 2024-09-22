import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:smartshop/common/widget/Verify/t_verify_text.dart';
import 'package:smartshop/common/widget/custom_shape/containers/rounded_container.dart';
import 'package:smartshop/utils/constants/sizes.dart';

class TBrandShowCase extends StatelessWidget {
  const TBrandShowCase({
    super.key,
    required this.image,
    required this.brandName,
    this.totalProduct = "256 Product",
  });

  final String image;
  final String brandName;
  final String totalProduct;

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      padding: const EdgeInsets.all(TSizes.sm),
      backgroundColor: Colors.transparent,
      showBorder: true,
      child: Padding(
        padding:
            const EdgeInsets.only(top: 15, bottom: 15, left: 10, right: 10),
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CachedNetworkImage(
                    height: 56,
                    width: 56,
                    imageUrl: image,
                  ),
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
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: SizedBox(
            //     height: 120, // Adjust the height to fit images
            //     child: ListView(
            //       scrollDirection: Axis.horizontal,
            //       children: productImages
            //           .map(
            //             (image) => BrandImages(image, context),
            //           )
            //           .toList(),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

// Widget BrandImages(String image, context) {
//   return Expanded(
//     child: TRoundedContainer(
//       height: 100,
//       padding: const EdgeInsets.all(TSizes.md),
//       margin: const EdgeInsets.only(right: TSizes.sm),
//       backgroundColor: THelperFunctions.isDarkMode(context)
//           ? TColors.darkGrey
//           : TColors.light,
//       child: Image(
//         image: AssetImage(image),
//         fit: BoxFit.cover,
//       ),
//     ),
//   );
// }
