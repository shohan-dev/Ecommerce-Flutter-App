import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartshop/common/widget/appbar/appbar.dart';
import 'package:smartshop/common/widget/effect/shimmer_effect.dart';
import 'package:smartshop/features/personailzation/controllers/user_controllers.dart';
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
    final controller = UserController.instance;
    // RxBool isLoading = controller.isLoading.value.obs;
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
          const SizedBox(
            height: 5,
          ),
          Obx(
            () {
              if (controller.isLoading.value) {
                return const TShimmerEffect(height: 20, width: 200);
              }
              return Text(
                "Welcome, ${controller.user.value?.lastName ?? ""}",
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .apply(color: TColors.white),
              );
            },
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
