import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:smartshop/common/widget/icons/circular_icons.dart';
import 'package:smartshop/common/widget/snackbar/snackbar.dart';
import 'package:smartshop/features/shop/controllers/cart/cart_controller.dart';
import 'package:smartshop/features/shop/controllers/product_details/product_details.dart';
import 'package:smartshop/features/shop/models/product_models.dart';
import 'package:smartshop/utils/constants/colors.dart';
import 'package:smartshop/utils/constants/sizes.dart';
import 'package:smartshop/utils/helpers/helper_functions.dart';

class TBottomAdToCart extends StatefulWidget {
  const TBottomAdToCart({
    super.key,
    required this.product,
  });

  final ProductModels product;

  @override
  _TBottomAdToCartState createState() => _TBottomAdToCartState();
}

class _TBottomAdToCartState extends State<TBottomAdToCart> {
  int quantity = 1;

  void _incrementQuantity() {
    setState(() {
      quantity++;
    });
  }

  void _decrementQuantity() {
    setState(() {
      if (quantity > 1) {
        quantity--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final cartcontroller = CartController.instance;
    final selectedColorobs = Get.put(ProductDetailsController()).selectedColor;
    final selectedSizeobs = Get.put(ProductDetailsController()).selectedSize;

    var selectedColorName = "";

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
                onTap: _decrementQuantity,
                child: const TCircularIcon(
                  icon: Iconsax.minus,
                  backgroundColor: Color.fromARGB(255, 170, 170, 170),
                  width: 40,
                  height: 40,
                  color: TColors.white,
                ),
              ),
              const SizedBox(
                width: TSizes.spaceBtwItems,
              ),
              Text(
                quantity.toString(),
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(
                width: TSizes.spaceBtwItems,
              ),
              GestureDetector(
                onTap: _incrementQuantity,
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
                // selectct color and size if empty add Tsnackbar
                if (selectedColorobs.value == "") {
                  TLoaders.warningSnackBar(
                      title: "Select Color for the product");
                  return;
                }
                if (selectedSizeobs.value == "") {
                  TLoaders.warningSnackBar(
                      title: "Select Size for the product");
                  return;
                }
                // get the selected color name
                if (selectedColorobs.hashCode == 265523868) {
                  selectedColorName = "Red";
                } else if (selectedColorobs.hashCode == 213129631) {
                  selectedColorName = "Green";
                } else if (selectedColorobs.hashCode == 397551850) {
                  selectedColorName = "Blue";
                }

                cartcontroller.addToCart(
                  widget.product,
                  selectedColorName,
                  selectedSizeobs.value,
                  quantity,
                );
                TLoaders.successSnackBar(
                    title: "Product added to cart",
                    message: "Product added to cart successfully");
              },
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(TSizes.md),
                  backgroundColor: TColors.black,
                  side: const BorderSide(color: TColors.black)),
              child: const Text("Add to Cart"))
        ],
      ),
    );
  }
}
