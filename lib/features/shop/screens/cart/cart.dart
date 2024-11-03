import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartshop/common/widget/appbar/appbar.dart';
import 'package:smartshop/features/shop/controllers/cart/cart_controller.dart';
import 'package:smartshop/features/shop/controllers/product_details/product_details.dart';
import 'package:smartshop/features/shop/screens/cart/widgets/cart_details.dart';
import 'package:smartshop/features/shop/screens/checkout/checkout.dart';
import 'package:smartshop/utils/constants/sizes.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CartController());
    final selectedColorobs = Get.put(ProductDetailsController()).selectedColor;
    final selectedSizeobs = Get.put(ProductDetailsController()).selectedSize;
    var selectedColorName = "";

    // Get the selected color name
    if (selectedColorobs.hashCode == 265523868) {
      selectedColorName = "Red";
    } else if (selectedColorobs.hashCode == 213129631) {
      selectedColorName = "Green";
    } else if (selectedColorobs.hashCode == 397551850) {
      selectedColorName = "Blue";
    }

    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: Text(
          "Cart",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: Obx(() {
        if (controller.cartList.isEmpty) {
          // Display an empty cart message
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.shopping_cart_outlined,
                    size: 80, color: Colors.grey),
                const SizedBox(height: 20),
                Text(
                  "Your cart is empty!",
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 10),
                Text(
                  "Looks like you haven't added any products yet.",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey,
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
              ],
            ),
          );
        } else {
          // Display cart items if not empty
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: TCartItemsListDetails(
                cartList: controller.cartList,
              ),
            ),
          );
        }
      }),
      bottomNavigationBar: Obx(() {
        final totalPrice = controller.getTotalPrice(controller.cartList);
        return Padding(
          padding: const EdgeInsets.only(
            bottom: TSizes.defaultSpace,
            left: TSizes.defaultSpace,
            right: TSizes.defaultSpace,
          ),
          child: ElevatedButton(
            onPressed: controller.cartList.isNotEmpty
                ? () => Get.to(() => CheckoutScreenPage(
                      cartList: controller.cartList,
                      selectedColor: selectedColorName,
                      selectedSize: selectedSizeobs.value,
                    ))
                : null,
            child: Text("Checkout  \$${totalPrice.toStringAsFixed(2)}"),
          ),
        );
      }),
    );
  }
}
