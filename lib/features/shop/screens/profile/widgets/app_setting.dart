import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/common/widget/list_tile/setting_menu_tiles.dart';
import 'package:t_store/common/widget/texts/section_heading.dart';
import 'package:t_store/utils/constants/sizes.dart';

class AppSetting extends StatelessWidget {
  const AppSetting({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const TSectionHeading(
          title: "App Settings",
          showActionButton: false,
        ),
        const TSettingMenuTiles(
            icon: Iconsax.document_upload,
            title: "Load Data",
            subtitle: "Upload Data to your Cloud Firebase"),
        TSettingMenuTiles(
          icon: Iconsax.security_user,
          title: "Geolocation",
          subtitle: "Set recommendation based on location",
          trailing: Switch(value: false, onChanged: (value) {}),
        ),
        TSettingMenuTiles(
          icon: Iconsax.security_user,
          title: "Safe Mode",
          subtitle: "Search result is safe for all ages",
          trailing: Switch(value: true, onChanged: (value) {}),
        ),
        TSettingMenuTiles(
          icon: Iconsax.image,
          title: "Hd Image Quality",
          subtitle: "Set image quality to be seen",
          trailing: Switch(value: false, onChanged: (value) {}),
        ),
        const SizedBox(
          height: TSizes.spaceBtwSections,
        ),
        //----Button Logout----------------
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(onPressed: () {}, child: const Text("Logout")),
        ),

        const SizedBox(
          height: TSizes.spaceBtwSections,
        ),
      ],
    );
  }
}
