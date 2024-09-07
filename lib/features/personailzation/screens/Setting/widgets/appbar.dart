import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartshop/common/widget/appbar/appbar.dart';
import 'package:smartshop/common/widget/custom_shape/containers/primary_header_container.dart';
import 'package:smartshop/common/widget/list_tile/user_profile_tiles.dart';
import 'package:smartshop/features/personailzation/controllers/user_controllers.dart';
import 'package:smartshop/features/personailzation/screens/Profile/profile.dart';
import 'package:smartshop/utils/constants/colors.dart';

class TAppbarProfile extends StatelessWidget {
  const TAppbarProfile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = UserControllers.instance;
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
              child: Obx(
                () => TUserProfileTiles(
                  name: controller.user.value!.fullName,
                  email: controller.user.value!.email,
                  onPressed: () => Get.to(() => const ProfileScreen()),
                ),
              ),
            ),
          ],
        ));
  }
}
