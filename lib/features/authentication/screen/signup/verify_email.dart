import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartshop/features/authentication/controllers/signup/verify_email.controller.dart';
import 'package:smartshop/utils/constants/image_strings.dart';
import 'package:smartshop/utils/constants/sizes.dart';
import 'package:smartshop/utils/constants/text_strings.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({
    super.key,
    required this.emailGet,
  });

  final String emailGet;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VerifyEmailController());

    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
                onPressed: () {
                  controller.signOut(); // close ActionButton
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
                Text(
                  emailGet,
                  style: const TextStyle(fontSize: 11),
                  textAlign: TextAlign.center,
                ),
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
                        controller
                            .checkEmailVerificationStatus(); // continue button
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
                        controller
                            .sendEmailVerification(); // resend email action button
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
