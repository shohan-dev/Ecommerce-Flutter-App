import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/common/widget/list_tile/setting_menu_tiles.dart';
import 'package:t_store/common/widget/texts/section_heading.dart';
import 'package:t_store/utils/constants/sizes.dart';

class AccountSetting extends StatelessWidget {
  const AccountSetting({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        TSectionHeading(
          title: "Account Settings",
          showActionButton: false,
        ),
        TSettingMenuTiles(
            icon: Iconsax.safe_home,
            title: "My Address",
            subtitle: "Set Shopping delevery address"),
        TSettingMenuTiles(
            icon: Iconsax.shopping_cart,
            title: "My Cart",
            subtitle: "Add, Remove products and move to checkout"),
        TSettingMenuTiles(
            icon: Iconsax.bag_tick,
            title: "My Order",
            subtitle: "In-progress and Completed Orders"),
        TSettingMenuTiles(
            icon: Iconsax.bank,
            title: "Bank Account",
            subtitle: "Withdraw balance to registred bank account"),
        TSettingMenuTiles(
            icon: Iconsax.discount_shape,
            title: "My Coupons",
            subtitle: "List of all the discounted coupons"),
        TSettingMenuTiles(
            icon: Iconsax.notification,
            title: "Notifications",
            subtitle: "Set any kind of notification message"),
        TSettingMenuTiles(
            icon: Iconsax.security_card,
            title: "Account Privacy",
            subtitle: "Manage data usage and connected accounts"),
        SizedBox(
          height: TSizes.spaceBtwSections,
        ),
      ],
    );
  }
}
