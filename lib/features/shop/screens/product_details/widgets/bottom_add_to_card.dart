import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:smartshop/common/widget/icons/circular_icons.dart';
import 'package:smartshop/common/widget/snackbar/snackbar.dart';
import 'package:smartshop/features/shop/controllers/cart/add_to_cart_controller.dart';
import 'package:smartshop/features/shop/controllers/product_details/product_details.dart';
import 'package:smartshop/features/shop/models/product_models.dart';
import 'package:smartshop/utils/constants/colors.dart';
import 'package:smartshop/utils/constants/sizes.dart';
import 'package:smartshop/utils/helpers/helper_functions.dart';

class TBottomAdToCart extends StatelessWidget {
  const TBottomAdToCart({
    Key? key,
    required this.product,
  }) : super(key: key);

  final ProductModels product;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final cartController = AddToCartController.instance;
    final selectedColorObs = Get.put(ProductDetailsController()).selectedColor;
    final selectedSizeObs = Get.put(ProductDetailsController()).selectedSize;

    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: TSizes.defaultSpace, vertical: TSizes.defaultSpace / 2),
      decoration: BoxDecoration(
          color: dark ? TColors.darkGrey : TColors.light,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(TSizes.cardRadiusLg),
              topRight: Radius.circular(TSizes.cardRadiusLg))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: cartController.decrementQuantity,
                child: const TCircularIcon(
                  icon: Iconsax.minus,
                  backgroundColor: Color.fromARGB(255, 170, 170, 170),
                  width: 40,
                  height: 40,
                  color: TColors.white,
                ),
              ),
              const SizedBox(width: TSizes.spaceBtwItems),
              Obx(() => Text(
                    cartController.quantity.value.toString(),
                    style: Theme.of(context).textTheme.titleSmall,
                  )),
              const SizedBox(width: TSizes.spaceBtwItems),
              GestureDetector(
                onTap: cartController.incrementQuantity,
                child: const TCircularIcon(
                  icon: Iconsax.add,
                  backgroundColor: TColors.black,
                  width: 40,
                  height: 40,
                  color: TColors.white,
                ),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () {
              // Check selected color and size
              if (selectedColorObs.value.isEmpty) {
                TLoaders.warningSnackBar(title: "Select Color for the product");
                return;
              }
              if (selectedSizeObs.value.isEmpty) {
                TLoaders.warningSnackBar(title: "Select Size for the product");
                return;
              }
              var selectedColorName = "";

              // get the selected color name
              if (selectedColorObs.hashCode == 265523868) {
                selectedColorName = "Red";
              } else if (selectedColorObs.hashCode == 213129631) {
                selectedColorName = "Green";
              } else if (selectedColorObs.hashCode == 397551850) {
                selectedColorName = "Blue";
              }

              // Add to cart
              cartController.addToCart(
                product.toJson(),
                selectedColorName,
                selectedSizeObs.value,
                cartController.quantity.value,
              );

              TLoaders.successSnackBar(
                title: "Product added to cart",
                message: "Product added to cart successfully",
              );

              // Reset quantity
              cartController.quantity.value = 1;
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(TSizes.md),
              backgroundColor: TColors.black,
              side: const BorderSide(color: TColors.black),
            ),
            child: const Text("Add to Cart"),
          ),
        ],
      ),
    );
  }
}
