import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartshop/features/authentication/controllers/onboading/onboading_controller.dart';
import 'package:smartshop/utils/constants/colors.dart';
import 'package:smartshop/utils/constants/sizes.dart';
import 'package:smartshop/utils/device/device_utility.dart';
import 'package:smartshop/utils/helpers/helper_functions.dart';

class OnBoardBottonNavigationButton extends StatelessWidget {
  const OnBoardBottonNavigationButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final controller =
        Get.put(OnboardingController()); // Using existing controller instance

    return Positioned(
      bottom: TDeviceUtils.getBottomNavigationBarHeight(),
      right: TSizes.defaultSpace,
      child: Obx(
        () => ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            backgroundColor: dark ? TColors.primary : TColors.dark,
            padding:
                const EdgeInsets.all(20), // Adjust the padding if necessary
          ),
          onPressed: () {
            controller.nextPage();
          },
          child: controller.isLoading.value
              ? const SizedBox(
                  height: 24.0,
                  width: 24.0,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    strokeWidth: 2.0,
                  ),
                )
              : const Icon(
                  Icons.arrow_forward_ios_rounded,
                ),
        ),
      ),
    );
  }
}
