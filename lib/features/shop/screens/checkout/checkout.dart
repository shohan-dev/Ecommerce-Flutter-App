import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartshop/common/widget/appbar/appbar.dart';
import 'package:smartshop/common/widget/custom_shape/containers/rounded_container.dart';
import 'package:smartshop/common/widget/products/cart/cupon_section.dart';
import 'package:smartshop/common/widget/success_screen.dart';
import 'package:smartshop/features/shop/screens/checkout/widgets/billing_address_section.dart';
import 'package:smartshop/features/shop/screens/checkout/widgets/billing_payment_section.dart';
import 'package:smartshop/features/shop/screens/checkout/widgets/billing_amount_section.dart';
import 'package:smartshop/navigation_menu.dart';
import 'package:smartshop/utils/constants/colors.dart';
import 'package:smartshop/utils/constants/image_strings.dart';
import 'package:smartshop/utils/constants/sizes.dart';
import 'package:smartshop/utils/helpers/helper_functions.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
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
              // const TCartItemsList(
              //   showAddRemoveButton: false,
              // ),
              const SizedBox(height: TSizes.spaceBtwSections),

              // Cuppon code section
              const TCuponCode(),
              const SizedBox(height: TSizes.spaceBtwSections),

              TRoundedContainer(
                  showBorder: true,
                  backgroundColor: dark ? TColors.dark : TColors.white,
                  child: const Padding(
                    padding: EdgeInsets.all(TSizes.defaultSpace),
                    child: TBillingAmountSection(),
                  )),
              const SizedBox(height: TSizes.spaceBtwSections),
              // payment and address section
              TRoundedContainer(
                  showBorder: true,
                  backgroundColor: dark ? TColors.dark : TColors.white,
                  child: const Padding(
                    padding: EdgeInsets.all(TSizes.defaultSpace),
                    child: Column(
                      children: [
                        TBillingPaymentSection(),
                        TBillingAddressSection(),
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
                    onPressed: () {
                      Get.to(() => const NavigationMenuPage());
                    },
                  ));
            },
            child: const Text("Checkout \$262"),
          ),
        ),
      ),
    );
  }
}
