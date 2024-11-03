import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartshop/common/widget/appbar/appbar.dart';
import 'package:smartshop/features/shop/controllers/cart/cart_controller.dart';
import 'package:smartshop/features/shop/screens/cart/widgets/cart_details.dart';
import 'package:smartshop/features/shop/screens/checkout/checkout.dart';
import 'package:smartshop/utils/constants/sizes.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CartController());

    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: Text(
          "Cart",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: TCartItemsListDetails(
            cartList: controller.cartList,
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(
          bottom: TSizes.defaultSpace,
          left: TSizes.defaultSpace,
          right: TSizes.defaultSpace,
        ),
        child: Obx(() {
          final totalPrice = controller.getTotalPrice(controller.cartList);
          return ElevatedButton(
            onPressed: () => Get.to(() => const CheckoutScreen()),
            child: Text("Checkout  \$${totalPrice.toStringAsFixed(2)}"),
          );
        }),
      ),
    );
  }
}
