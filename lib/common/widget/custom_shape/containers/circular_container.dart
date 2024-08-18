import 'package:flutter/material.dart';
import 'package:smartshop/utils/constants/colors.dart';

class TCircularContainer extends StatelessWidget {
  const TCircularContainer({
    super.key,
    this.width = 400,
    this.height = 400,
    this.radius = 400,
    this.padding = 0,
    this.child,
    this.backgroundColor = TColors.white,
    this.showCheckIcon = false, // Add this parameter
  });

  final double? width;
  final double? height;
  final double radius;
  final double padding;
  final Widget? child;
  final Color backgroundColor;
  final bool showCheckIcon; // Add this parameter

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: height,
          width: width,
          padding: EdgeInsets.all(padding),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
            color: backgroundColor,
          ),
          child: child,
        ),
        if (showCheckIcon)
          const Icon(
            Icons.check,
            color: Colors.white,
            size: 20,
          ),
      ],
    );
  }
}
