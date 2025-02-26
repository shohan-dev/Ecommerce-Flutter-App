import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:smartshop/features/shop/controllers/cart/cart_controller.dart';
import 'package:smartshop/utils/constants/colors.dart';

class TCartCounterIcon extends StatelessWidget {
  const TCartCounterIcon({
    super.key,
    required this.iconColor,
    required this.onpressed,
  });

  final Color iconColor;
  final VoidCallback onpressed;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CartController());
    return Stack(
      children: [
        IconButton(
            onPressed: onpressed,
            icon: const Icon(
              Iconsax.shopping_bag,
              color: TColors.white,
            )),
        Positioned(
            right: 0,
            child: Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(100)),
              child: Center(
                child: Obx(
                  () => Text(
                    controller.cartList.length.toString(),
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .apply(color: TColors.white, fontSizeFactor: 0.8),
                  ),
                ),
              ),
            )),
      ],
    );
  }
}
