import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartshop/common/widget/appbar/appbar.dart';
import 'package:smartshop/features/shop/screens/cart/widgets/cart.dart';
import 'package:smartshop/utils/constants/colors.dart';
import 'package:smartshop/utils/constants/text_strings.dart';
import 'package:smartshop/common/widget/products/cart/cart_menu_icon.dart';

class THomeAppbar extends StatelessWidget {
  const THomeAppbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Declare a reactive variable
    final RxBool isLoading = true.obs;

    // Start a timer to update the loading state
    Future<void> _startLoading() async {
      await Future.delayed(const Duration(seconds: 3));
      isLoading.value = false;
    }

    // Start loading when the widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startLoading();
    });

    return TAppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            TTexts.homeAppbarTitle,
            style: Theme.of(context)
                .textTheme
                .labelMedium!
                .apply(color: TColors.grey),
          ),
          Obx(
            () => isLoading.value
                ? const CircularProgressIndicator()
                : Text(
                    "Welcome, ${"user".capitalizeFirst}",
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium!
                        .apply(color: TColors.white),
                  ),
          ),
        ],
      ),
      actions: [
        TCartCounterIcon(
          iconColor: TColors.white,
          onpressed: () {
            Get.to(() => const CartScreen());
          },
        )
      ],
    );
  }
}
