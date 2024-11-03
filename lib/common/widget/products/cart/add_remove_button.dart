import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:smartshop/common/widget/icons/circular_icons.dart';
import 'package:smartshop/features/shop/controllers/cart/cart_controller.dart';
import 'package:smartshop/utils/constants/colors.dart';
import 'package:smartshop/utils/constants/sizes.dart';
import 'package:smartshop/utils/helpers/helper_functions.dart';

class TProductQuantityWithAddRemoveButton extends StatelessWidget {
  const TProductQuantityWithAddRemoveButton({
    super.key,
    required this.cartIndex, // Index of the product in the cart
  });

  final int cartIndex;

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;

    return Obx(
      () {
        // Access the quantity and price of the product from the cart
        final quantity = controller.cartList[cartIndex]['quantity'];
        final price =
            (controller.cartList[cartIndex]['price'] as num).toDouble();

        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Remove button
            TCircularIcon(
              icon: Iconsax.minus,
              width: 32,
              height: 32,
              size: TSizes.md,
              color: THelperFunctions.isDarkMode(context)
                  ? TColors.white
                  : TColors.black,
              backgroundColor: THelperFunctions.isDarkMode(context)
                  ? TColors.darkGrey
                  : TColors.light,
              onPressed: () {
                if (quantity > 1) {
                  controller.updateQuantity(cartIndex, quantity - 1, price);
                }
              },
            ),
            const SizedBox(width: TSizes.spaceBtwItems),
            Text(
              quantity.toString(),
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(width: TSizes.spaceBtwItems),
            // Add button
            TCircularIcon(
              icon: Iconsax.add,
              width: 32,
              height: 32,
              size: TSizes.md,
              color: TColors.white,
              backgroundColor: TColors.primary,
              onPressed: () {
                controller.updateQuantity(cartIndex, quantity + 1, price);
              },
            ),
          ],
        );
      },
    );
  }
}
