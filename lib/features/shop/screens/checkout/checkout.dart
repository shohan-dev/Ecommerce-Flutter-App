import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartshop/common/widget/appbar/appbar.dart';
import 'package:smartshop/common/widget/custom_shape/containers/rounded_container.dart';
import 'package:smartshop/common/widget/snackbar/snackbar.dart';
import 'package:smartshop/common/widget/success_screen.dart';
import 'package:smartshop/features/shop/controllers/cart/cart_controller.dart';
import 'package:smartshop/features/shop/controllers/product_details/product_success_controller.dart';
import 'package:smartshop/features/shop/controllers/single_checkout/single_checkout_controller.dart';
import 'package:smartshop/features/shop/screens/checkout/widgets/billing_amount_section.dart';
import 'package:smartshop/features/shop/screens/checkout/widgets/listview_items.dart';
import 'package:smartshop/features/shop/screens/single_checkout/widgets/billing_address_section.dart';
import 'package:smartshop/features/shop/screens/single_checkout/widgets/billing_payment_section.dart';
import 'package:smartshop/features/shop/screens/single_checkout/widgets/cupon_section.dart';

import 'package:smartshop/navigation_menu.dart';
import 'package:smartshop/utils/constants/colors.dart';
import 'package:smartshop/utils/constants/image_strings.dart';
import 'package:smartshop/utils/constants/sizes.dart';
import 'package:smartshop/utils/helpers/helper_functions.dart';

class CheckoutScreenPage extends StatelessWidget {
  const CheckoutScreenPage(
      {super.key,
      required this.selectedColor,
      required this.selectedSize,
      required this.cartList});

  final String selectedColor, selectedSize;
  final RxList<Map<String, dynamic>> cartList;

  @override
  Widget build(BuildContext context) {
    final address = SingleCheckoutController.instance.addressList;
    final controller = Get.put(CartController());

    final dark = THelperFunctions.isDarkMode(context);
    double taxFee = 6.0 * controller.cartList.length;
    double shoppingFee = 10.0 * controller.cartList.length;

    final toalPrice =
        controller.getTotalPrice(controller.cartList).toStringAsFixed(2);

    final final_totalPrices = (double.parse(toalPrice) + taxFee + shoppingFee);

    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title:
            Text("Checkout", style: Theme.of(context).textTheme.headlineSmall),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              // listview builder for cart items
              ListviewItems(
                cartList: controller.cartList,
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              // Cuppon code section
              const TCuponCodeSingle(),
              const SizedBox(height: TSizes.spaceBtwSections),

              TRoundedContainer(
                  showBorder: true,
                  backgroundColor: dark ? TColors.dark : TColors.white,
                  child: const Padding(
                    padding: EdgeInsets.all(TSizes.defaultSpace),
                    // child: TAddressSectionSingle(),
                    child: TAddressSectionSingle(),
                  )),
              const SizedBox(height: TSizes.spaceBtwSections),
              // payment and address section
              TRoundedContainer(
                  showBorder: true,
                  backgroundColor: dark ? TColors.dark : TColors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(TSizes.defaultSpace),
                    child: Column(
                      children: [
                        const TBillingPaymentSectionSingle(),
                        TBillingAmountSection(
                          price: double.parse(toalPrice),
                          taxFee: taxFee,
                          shoppingFee: shoppingFee,
                          totalPrices: final_totalPrices,
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              // if address is empty, show a message to add an address
              if (address.isEmpty) {
                TLoaders.warningSnackBar(
                    title: "Error", message: "Please add address");
                return;
              }

              // Update the order
              Get.put(ProductSuccessController());
              ProductSuccessController.instance.updateProductOrderMultiple(
                  selectedColor, selectedSize, cartList);

              Get.offAll(() => SuccessScreenPage(
                    title: "Order Placed",
                    subtitle: "Your order has been placed successfully",
                    image: TImages.successfulPaymentIcon,
                    buttonName: "Back to Home",
                    isLotti: false,
                    onPressed: () {
                      Get.to(() => const NavigationMenuPage());
                    },
                  ));
            },
            child: Text("Checkout $final_totalPrices"),
            // child: Text("Checkout "),
          ),
        ),
      ),
    );
  }
}
