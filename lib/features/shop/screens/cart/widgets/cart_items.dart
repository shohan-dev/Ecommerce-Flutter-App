import 'package:flutter/material.dart';
import 'package:smartshop/common/widget/products/cart/add_remove_button.dart';
import 'package:smartshop/common/widget/products/cart/cart_item.dart';
import 'package:smartshop/common/widget/texts/product_price_text.dart';
import 'package:smartshop/utils/constants/sizes.dart';

class TCartItemsList extends StatelessWidget {
  const TCartItemsList({
    super.key,
    this.showAddRemoveButton = true,
  });

  final bool showAddRemoveButton;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        shrinkWrap: true,
        itemCount: 5,
        separatorBuilder: (_, __) => const SizedBox(
              height: TSizes.spaceBtwSections,
            ),
        itemBuilder: (_, __) => Column(
              children: [
                const TCartItems(),

                // under if condition to show add remove button--------------------------------------------------------
                if (showAddRemoveButton)
                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                if (showAddRemoveButton)
                  const Row(
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
                // under if condition to show add remove button--------------------------------------------------------
              ],
            ));
  }
}
