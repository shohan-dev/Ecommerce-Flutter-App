import 'package:flutter/material.dart';
import 'package:t_store/common/widget/appbar/appbar.dart';
import 'package:t_store/common/widget/products/cart/add_remove_button.dart';
import 'package:t_store/common/widget/products/cart/cart_item.dart';
import 'package:t_store/common/widget/texts/product_price_text.dart';
import 'package:t_store/utils/constants/sizes.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
          child: ListView.separated(
              shrinkWrap: true,
              itemCount: 5,
              separatorBuilder: (_, __) => const SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),
              itemBuilder: (_, __) => const Column(
                    children: [
                      TCartItems(),
                      SizedBox(
                        height: TSizes.spaceBtwItems,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 70,
                              ),
                              TProductQuantityWithAddRemoveButton(), // both buttons add and remove
                            ],
                          ),
                          TProductPriceText(
                            price: '250',
                          ),
                        ],
                      ),
                    ],
                  )),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(
            bottom: TSizes.defaultSpace,
            left: TSizes.defaultSpace,
            right: TSizes.defaultSpace),
        child: ElevatedButton(
          onPressed: () {},
          child: const Text("Checkout \$1250"),
        ),
      ),
    );
  }
}
