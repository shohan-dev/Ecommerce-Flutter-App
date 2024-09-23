import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:smartshop/common/widget/appbar/appbar.dart';
import 'package:smartshop/common/widget/custom_shape/curved_edges/curved_edges_widgets.dart';
import 'package:smartshop/common/widget/images/t_round_images.dart';
import 'package:smartshop/features/shop/models/product_models.dart';
import 'package:smartshop/utils/constants/colors.dart';
import 'package:smartshop/utils/constants/sizes.dart';
import 'package:smartshop/utils/helpers/helper_functions.dart';

class TProductImageSlider extends StatefulWidget {
  const TProductImageSlider({
    Key? key,
    required this.product,
  }) : super(key: key);

  final ProductModels product;

  @override
  _TProductImageSliderState createState() => _TProductImageSliderState();
}

class _TProductImageSliderState extends State<TProductImageSlider> {
  late List<String> _images;
  int _selectedIndex = 0; // Track the selected image index

  @override
  void initState() {
    super.initState();
    _images =
        List.from(widget.product.images!); // Initialize with product images
  }

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return TCurvedEdgesWidgets(
      child: Container(
        color: dark ? TColors.darkGrey : TColors.light,
        child: Stack(
          children: [
            SizedBox(
              height: 630,
              child: Padding(
                padding: const EdgeInsets.all(TSizes.productImageRadius * 2),
                child: Center(
                  child: CachedNetworkImage(
                    imageUrl: _images.isNotEmpty ? _images[_selectedIndex] : '',
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: SizedBox(
                height: 80,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (_, __) =>
                      const SizedBox(width: TSizes.spaceBtwItems),
                  itemCount: _images.length,
                  itemBuilder: (_, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedIndex = index; // Update the selected index
                        });
                      },
                      child: TRoundImage(
                        width: 80,
                        backgroundColor: dark ? TColors.dark : TColors.white,
                        border: Border.all(
                          color: _selectedIndex == index
                              ? TColors.primary
                              : Colors.transparent,
                          width: 2, // Adjust the width as necessary
                        ),
                        padding: const EdgeInsets.all(TSizes.sm),
                        imageUrl: _images[index],
                        isNetworkImage: true, // Use only network images
                      ),
                    );
                  },
                ),
              ),
            ),
            const TAppBar(
              showBackArrow: true,
              actions: [Icon(Iconsax.heart5)],
            ),
          ],
        ),
      ),
    );
  }
}
