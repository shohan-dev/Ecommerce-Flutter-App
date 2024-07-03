import 'package:flutter/material.dart';
import 'package:t_store/features/authentication/controllers/onboading/onboading_controller.dart';
// import 'package:t_store/features/authentication/controllers/onboarding/onboarding_controller.dart'; // Corrected import path
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/device/device_utility.dart';

class OnBoardingSkip extends StatelessWidget {
  const OnBoardingSkip({Key? key})
      : super(key: key); // Corrected constructor syntax

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: TDeviceUtils.getAppBarHeight(),
      right: TSizes.defaultSpace,
      child: TextButton(
        onPressed: () {
          OnboardingController.instance.skipPage();
          print("Pressed");
        },
        child: const Text("Skip"),
      ),
    );
  }
}
