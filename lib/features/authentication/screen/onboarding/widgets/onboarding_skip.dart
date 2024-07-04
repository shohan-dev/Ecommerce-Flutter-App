import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/features/authentication/screen/login/login.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/constants/text_strings.dart';
import 'package:t_store/utils/device/device_utility.dart';

class OnBoardingSkip extends StatelessWidget {
  const OnBoardingSkip({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: TDeviceUtils.getAppBarHeight(),
        right: TSizes.defaultSpace,
        child: GestureDetector(
          onTap: () {
            Get.to(() => const LoginPage());
          },
          child: const Text(
            TTexts.skip,
            // style: TextStyle(
            //   color: Colors.blue,
            //   decoration: TextDecoration.underline,
            // ),
          ),
        ));
  }
}
