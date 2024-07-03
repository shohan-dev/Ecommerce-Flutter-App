import 'package:flutter/material.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/constants/text_strings.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
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
    );
  }
}

class OnBoardPage extends StatelessWidget {
  const OnBoardPage({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.image,
  }) : super(key: key);

  final String title, subtitle, image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image(
          width: THelperFunctions.screenWidth() * 0.8,
          height: THelperFunctions.screenHeight() * 0.6,
          image: AssetImage(image),
        ),
        const SizedBox(height: TSizes.spaceBtwItems),
        Text(
          title,
          style: Theme.of(context).textTheme.headlineMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: TSizes.spaceBtwItems),
        Text(
          subtitle,
          style: Theme.of(context).textTheme.bodyLarge,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
