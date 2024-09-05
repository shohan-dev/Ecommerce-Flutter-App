import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:smartshop/common/widget/success_screen.dart';
import 'package:smartshop/features/authentication/screen/login/login.dart';
import 'package:smartshop/utils/constants/image_strings.dart';
import 'package:smartshop/utils/constants/sizes.dart';
import 'package:smartshop/utils/constants/text_strings.dart';
import 'package:smartshop/utils/helpers/helper_functions.dart';

class ForgetPageScreen extends StatelessWidget {
  const ForgetPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: dark ? Colors.white : Colors.black),
        ),
        body: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                TTexts.forgetPasswordTitle,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(
                height: TSizes.defaultSpace,
              ),
              Text(
                TTexts.forgetPasswordSubTitle,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(
                height: TSizes.appBarHeight,
              ),
              const TextField(
                decoration: InputDecoration(
                    prefixIcon: Icon(Iconsax.direct_right),
                    labelText: TTexts.email),
              ),
              const SizedBox(
                height: TSizes.defaultSpace,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      Get.off(() => SuccessScreenPage(
                            buttonName: TTexts.done,
                            title: TTexts.changeYourPasswordTitle,
                            subtitle: TTexts.changeYourPasswordSubTitle,
                            image: TImages.deliveredEmailIllustration,
                            onPressed: () {
                              Get.offAll(() => const LoginPage());
                            },
                          ));
                    },
                    child: const Text(
                      TTexts.submit,
                    )),
              )
            ],
          ),
        ));
  }
}
