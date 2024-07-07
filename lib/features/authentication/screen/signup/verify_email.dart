import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:t_store/features/authentication/controllers/signup/verify_controller.dart';
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
                  VerifyPageController.instance
                      .closeActionButton(); // close ActionButton
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
                        VerifyPageController.instance
                            .continueButton(); // continue button
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
                        VerifyPageController.instance
                            .resendEmailActionButton(); // resend email action button
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