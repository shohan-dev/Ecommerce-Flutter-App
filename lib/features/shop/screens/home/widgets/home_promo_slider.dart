import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:t_store/common/widget/images/t_round_images.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/constants/sizes.dart';

class TPromoSlider extends StatelessWidget {
  const TPromoSlider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          children: [
            CarouselSlider(items: const [
              TRoundImage(imageUrl: TImages.banner1),
              TRoundImage(imageUrl: TImages.banner2),
              TRoundImage(imageUrl: TImages.banner3),
            ], options: CarouselOptions(viewportFraction: 1))
          ],
        ));
  }
}
