import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:smartshop/common/widget/list_tile/setting_menu_tiles.dart';
import 'package:smartshop/common/widget/texts/section_heading.dart';
import 'package:smartshop/features/personailzation/screens/address/address.dart';
import 'package:smartshop/features/shop/screens/cart/cart.dart';
import 'package:smartshop/features/shop/screens/order/order.dart';
import 'package:smartshop/utils/constants/sizes.dart';

class AccountSetting extends StatelessWidget {
  const AccountSetting({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const TSectionHeading(
          title: "Account Settings",
          showActionButton: false,
        ),
        TSettingMenuTiles(
          icon: Iconsax.safe_home,
          title: "My Address",
          subtitle: "Set Shopping delevery address",
          onTap: () => Get.to(const UserAddressScreen()),
        ),
        TSettingMenuTiles(
          icon: Iconsax.shopping_cart,
          title: "My Cart",
          subtitle: "Add, Remove products and move to checkout",
          onTap: () => Get.to(
            () => const CartScreen(),
          ),
        ),
        TSettingMenuTiles(
          icon: Iconsax.bag_tick,
          title: "My Order",
          subtitle: "In-progress and Completed Orders",
          onTap: () => Get.to(
            () => const OrderScreen(),
          ),
        ),
        const TSettingMenuTiles(
            icon: Iconsax.bank,
            title: "Bank Account",
            subtitle: "Withdraw balance to registred bank account"),
        const TSettingMenuTiles(
            icon: Iconsax.discount_shape,
            title: "My Coupons",
            subtitle: "List of all the discounted coupons"),
        const TSettingMenuTiles(
            icon: Iconsax.notification,
            title: "Notifications",
            subtitle: "Set any kind of notification message"),
        const TSettingMenuTiles(
            icon: Iconsax.security_card,
            title: "Account Privacy",
            subtitle: "Manage data usage and connected accounts"),
        const SizedBox(
          height: TSizes.spaceBtwSections - 5,
        ),
      ],
    );
  }
}
