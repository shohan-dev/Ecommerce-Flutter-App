import 'package:flutter/material.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';

class TRoundImage extends StatelessWidget {
  const TRoundImage({
    super.key,
    this.width,
    this.height,
    required this.imageUrl,
    this.applyImageRadius = true,
    this.isNetworkImage = false,
    this.border,
    this.backgroundColor = TColors.light,
    this.fit,
    this.padding,
    this.onPressed,
    this.borderRadius = TSizes.md,
  });

  final double? width, height;
  final String imageUrl;
  final bool applyImageRadius;
  final bool isNetworkImage;
  final BoxBorder? border;
  final Color backgroundColor;
  final BoxFit? fit;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onPressed;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(borderRadius)),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          child: Image(image: AssetImage(imageUrl))),
    );
  }
}
