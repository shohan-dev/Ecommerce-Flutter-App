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
    return TPrimaryHeaderContainer(
      height: 220,
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
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
            child: Obx(() {
              final isLoading = UserController.instance.isLoading
                  .value; // Adjust this based on your actual state
              if (isLoading) {
                return const TUserProfileTiles(
                  name: "Name",
                  email: "Email",
                );
              }
              final user = UserController.instance.user.value;
              return TUserProfileTiles(
                name: user?.fullName ?? '',
                email: user?.email ?? '',
                onPressed: () {
                  Get.to(() => const ProfileScreen());
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
