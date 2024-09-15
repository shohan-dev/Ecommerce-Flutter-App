import 'package:flutter/material.dart';
import 'package:smartshop/features/personailzation/screens/Setting/widgets/account_setting.dart';
import 'package:smartshop/features/personailzation/screens/Setting/widgets/app_setting.dart';
import 'package:smartshop/features/personailzation/screens/Setting/widgets/appbar.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // --------Apppbar --------
            
            TAppbarProfile(),
            
            // TextButton(
            //     onPressed: () {
            //       Get.to(() => AddProductPage());
            //     },
            //     child: const Text("Send")),
            Padding(
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
