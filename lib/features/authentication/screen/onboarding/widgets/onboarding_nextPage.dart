import 'package:flutter/material.dart';
import 'package:t_store/features/authentication/controllers/onboading/onboading_controller.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/device/device_utility.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

class OnBoardBottonNavigationButton extends StatelessWidget {
  const OnBoardBottonNavigationButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Positioned(
        bottom: TDeviceUtils.getBottomNavigationBarHeight() + 25,
        right: TSizes.defaultSpace,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                backgroundColor: dark ? TColors.primary : TColors.dark),
            onPressed: () {
              OnboardingController.instance.nextPage();
            },
            child: const Icon(Icons.arrow_forward_ios_rounded)));
  }
}
