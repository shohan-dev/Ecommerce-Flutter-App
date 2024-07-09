import 'package:flutter/material.dart';
import 'package:t_store/common/widget/custom_shape/containers/circular_container.dart';
import 'package:t_store/common/widget/custom_shape/curved_edges/curved_edges_widgets.dart';
import 'package:t_store/utils/constants/colors.dart';

class TPrimaryHeaderContainer extends StatelessWidget {
  const TPrimaryHeaderContainer({
    super.key,
    required this.child,
  });
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return TCurvedEdgesWidgets(
      child: Container(
        color: TColors.primary,
        padding: const EdgeInsets.all(0),
        child: SizedBox(
          height: 400,
          child: Stack(
            children: [
              Positioned(
                top: -150,
                right: -250,
                child: TCircularContainer(
                  backgroundColor: TColors.textWhite
                      .withOpacity(0.1), // round shape design 1st
                ),
              ),
              Positioned(
                top: 150,
                right: -300,
                child: TCircularContainer(
                  backgroundColor: TColors.textWhite
                      .withOpacity(0.1), // round shape design 2nd
                ),
              ),
              Positioned.fill(
                //full page content show
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    child, // Add the child here
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
