import 'package:flutter/material.dart';
import 'package:t_store/common/widget/custom_shape/containers/rounded_container.dart';
import 'package:t_store/features/shop/screens/product_details/widgets/attributes/discription.dart';
import 'package:t_store/utils/constants/colors.dart';

class TProductAttributes extends StatelessWidget {
  const TProductAttributes({
    super.key,
    required this.dark,
  });
  final bool dark;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Product Discription
        TProductDiscriptions(dark: dark)
        //Color
      ],
    );
  }
}
