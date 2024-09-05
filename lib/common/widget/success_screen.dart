import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:smartshop/utils/constants/sizes.dart';

class SuccessScreenPage extends StatelessWidget {
  const SuccessScreenPage(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.image,
      required this.buttonName,
      required this.onPressed});

  final String title, subtitle, image, buttonName;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          children: [
            const SizedBox(
              height: 100,
            ),
            // Image(image: AssetImage(image)),
            Lottie.asset(image),
            const SizedBox(
              height: 20,
            ),

            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: TSizes.defaultSpace, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Text(
                subtitle,
                style: const TextStyle(fontSize: 11),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              width: double.infinity,
              child:
                  ElevatedButton(onPressed: onPressed, child: Text(buttonName)),
            ),
            const SizedBox(
              height: TSizes.defaultSpace,
            ),
          ],
        ),
      ),
    ));
  }
}
