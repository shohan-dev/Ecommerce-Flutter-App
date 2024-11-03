import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:smartshop/common/widget/products/cart/add_remove_button.dart';
import 'package:smartshop/common/widget/products/cart/cart_item.dart';
import 'package:smartshop/common/widget/texts/product_price_text.dart';
import 'package:smartshop/utils/constants/sizes.dart';

class TCartItemsListDetails extends StatelessWidget {
  TCartItemsListDetails({
    super.key,
    this.showAddRemoveButton = true,
    required this.cartList,
  });

  final bool showAddRemoveButton;
  final RxList<Map<String, dynamic>> cartList;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        shrinkWrap: true,
        itemCount: cartList.length,
        separatorBuilder: (_, __) => const SizedBox(
              height: TSizes.spaceBtwSections,
            ),
        itemBuilder: (_, index) => Column(
              children: [
                TCartItems(
                  cartList: [cartList[index]],
                ),

                // under if condition to show add remove button--------------------------------------------------------
                if (showAddRemoveButton)
                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                if (showAddRemoveButton)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const SizedBox(
                            width: 70,
                          ),
                          TProductQuantityWithAddRemoveButton(
                            cartIndex: index,
                          ), // both buttons add and remove
                        ],
                      ),
                      Obx(
                        () => TProductPriceText(
                          price: cartList[index]['totalPrice'].toString(),
                        ),
                      ),
                    ],
                  ),
                // under if condition to show add remove button--------------------------------------------------------
              ],
            ));
  }
}
