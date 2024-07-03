import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/features/authentication/controllers/onboading/onboading_controller.dart';
import 'package:t_store/features/authentication/screen/onboarding/widgets/onboarding_dot_navigation.dart';
import 'package:t_store/features/authentication/screen/onboarding/widgets/onboarding_nextPage.dart';
import 'package:t_store/features/authentication/screen/onboarding/widgets/onboarding_page.dart';
import 'package:t_store/features/authentication/screen/onboarding/widgets/onboarding_skip.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/constants/text_strings.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnboardingController());

    return Scaffold(
      body: Stack(
        children: [
          // pageview swaps
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.updatePageIndicator,
            children: const [
              OnBoardPage(
                image: TImages.onBoardingImage1,
                title: TTexts.onBoardingTitle1,
                subtitle: TTexts.onBoardingSubTitle1,
              ),
              OnBoardPage(
                image: TImages.onBoardingImage2,
                title: TTexts.onBoardingTitle2,
                subtitle: TTexts.onBoardingSubTitle2,
              ),
              OnBoardPage(
                image: TImages.onBoardingImage3,
                title: TTexts.onBoardingTitle3,
                subtitle: TTexts.onBoardingSubTitle3,
              ),
            ],
          ),
          // Navigation style bar
          const OnBoradingNavigation(),
          // Navigation button
          const OnBoardBottonNavigationButton(),
          // skip buttons
          const OnBoardingSkip(),
        ],
      ),
    );
  }
}
