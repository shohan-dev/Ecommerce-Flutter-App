import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:iconsax/iconsax.dart';
import 'package:smartshop/utils/constants/sizes.dart';

class TProfileMenu extends StatelessWidget {
  const TProfileMenu(
      {super.key,
      required this.title,
      required this.value,
      this.icon = Iconsax.arrow_right_34,
      this.ontap});

  final String title;
  final String value;
  final IconData icon;
  final Callback? ontap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Padding(
        padding:
            const EdgeInsets.symmetric(vertical: TSizes.spaceBtwItems / 1.5),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Text(
                title,
                style: Theme.of(context).textTheme.bodySmall,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Expanded(
              flex: 5,
              child: Text(
                value,
                style: Theme.of(context).textTheme.bodyMedium,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Icon(icon)
          ],
        ),
      ),
    );
  }
}
