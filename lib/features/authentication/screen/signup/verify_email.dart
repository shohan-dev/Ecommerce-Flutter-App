import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/common/widget/success_screen.dart';
import 'package:t_store/features/authentication/screen/login/login.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/constants/text_strings.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const emailGet = "Sabbirshohan80@gmail.com";
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
                onPressed: () {
                  Get.off(() => const LoginPage());
                },
                icon: const Icon(CupertinoIcons.clear))
          ],
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: Column(
              children: [
                const Image(
                    image: AssetImage(TImages.deliveredEmailIllustration)),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  TTexts.confirmEmail,
                  style: TextStyle(
                      fontSize: TSizes.defaultSpace,
                      fontWeight: FontWeight.bold),
                ),
                const Text(emailGet),
                const Padding(
                  padding: EdgeInsets.all(TSizes.defaultSpace),
                  child: Text(
                    TTexts.confirmEmailSubTitle,
                    style: TextStyle(fontSize: 11),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {
                        Get.off(() => const SuccessScreenPage(
                              title: TTexts.yourAccountCreatedTitle,
                              subtitle: TTexts.yourAccountCreatedSubTitle,
                              image: TImages.staticSuccessIllustration,
                              buttonName: "Continue",
                            ));
                      },
                      child: const Text("Continue")),
                ),
                const SizedBox(
                  height: TSizes.defaultSpace,
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: GestureDetector(
                      onTap: () {
                        Get.off(() => const SuccessScreenPage(
                              title: "",
                              subtitle: "",
                              image: TImages.verifyIllustration,
                              buttonName: "Successful",
                            ));
                      },
                      child: const Text(
                        TTexts.resendEmail,
                        style: TextStyle(fontSize: 11),
                      ),
                    ))
              ],
            ),
          ),
        ));
  }
}
