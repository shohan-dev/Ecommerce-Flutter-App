import 'package:flutter/material.dart';
import 'package:t_store/common/widget/appbar/appbar.dart';
import 'package:t_store/common/widget/custom_shape/containers/primary_header_container.dart';
import 'package:t_store/common/widget/list_tile/user_profile_tiles.dart';
import 'package:t_store/features/shop/screens/profile/widgets/account_setting.dart';
import 'package:t_store/features/shop/screens/profile/widgets/app_setting.dart';
import 'package:t_store/utils/constants/colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            TPrimaryHeaderContainer(
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
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TUserProfileTiles(),
                    ),
                  ],
                )),
            const Padding(
              padding: EdgeInsets.all(15.0),
              child: Column(
                children: [
                  //-------Account Settings
                  AccountSetting(),
                  //----------App Settings
                  AppSetting(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
