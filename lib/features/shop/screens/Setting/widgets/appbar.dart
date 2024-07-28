import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/common/widget/appbar/appbar.dart';
import 'package:t_store/common/widget/custom_shape/containers/primary_header_container.dart';
import 'package:t_store/common/widget/list_tile/user_profile_tiles.dart';
import 'package:t_store/features/shop/screens/profile/profile.dart';
import 'package:t_store/utils/constants/colors.dart';

class TAppbarProfile extends StatelessWidget {
  const TAppbarProfile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TPrimaryHeaderContainer(
        height: 230,
        child: Column(
          children: [
            TAppBar(
              title: Text(
                "Account",
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .apply(color: TColors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TUserProfileTiles(
                name: 'Md Sabbir Roshid Shohan',
                email: 'shohan@gmail.com',
                onPressed: () => Get.to(() => const ProfileScreen()),
              ),
            ),
          ],
        ));
  }
}
