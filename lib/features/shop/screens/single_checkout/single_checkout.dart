import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartshop/common/widget/appbar/appbar.dart';
import 'package:smartshop/common/widget/custom_shape/containers/rounded_container.dart';
import 'package:smartshop/common/widget/success_screen.dart';
import 'package:smartshop/features/shop/models/product_models.dart';
import 'package:smartshop/features/shop/screens/single_checkout/widgets/billing_address_section.dart';
import 'package:smartshop/features/shop/screens/single_checkout/widgets/billing_amount_section.dart';
import 'package:smartshop/features/shop/screens/single_checkout/widgets/billing_payment_section.dart';
import 'package:smartshop/features/shop/screens/single_checkout/widgets/cart_items.dart';
import 'package:smartshop/features/shop/screens/single_checkout/widgets/cupon_section.dart';

import 'package:smartshop/navigation_menu.dart';
import 'package:smartshop/utils/constants/colors.dart';
import 'package:smartshop/utils/constants/image_strings.dart';
import 'package:smartshop/utils/constants/sizes.dart';
import 'package:smartshop/utils/helpers/helper_functions.dart';

class SingleCheckoutScreen extends StatelessWidget {
  const SingleCheckoutScreen(
      {super.key,
      required this.product,
      required this.selectedColor,
      required this.selectedSize});

  final ProductModels product;
  final String selectedColor, selectedSize;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    double taxFee = 6.0;
    double shoppingFeePercentage = 0.05;
    double shoppingFee = product.price! * shoppingFeePercentage;
    shoppingFee = double.parse(shoppingFee.toStringAsFixed(2));
    var totalPrices = product.price! + shoppingFee + taxFee;
    totalPrices = double.parse(totalPrices.toStringAsFixed(2));

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
              TCartItemsSingle(
                product: product,
                selectedColor: selectedColor,
                selectedSize: selectedSize,
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
                        TBillingAmountSectionSingle(
                          price: product.price!,
                          taxFee: taxFee,
                          shoppingFee: shoppingFee,
                          totalPrices: totalPrices,
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
            child: Text("Checkout $totalPrices"),
          ),
        ),
      ),
    );
  }
}
