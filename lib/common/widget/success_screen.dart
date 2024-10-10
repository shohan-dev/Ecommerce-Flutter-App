import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:smartshop/utils/constants/sizes.dart';

class SuccessScreenPage extends StatelessWidget {
  const SuccessScreenPage({
    super.key,
    required this.title,
    required this.subtitle,
    required this.image,
    required this.buttonName,
    required this.onPressed,
    this.isLotti = true,
    this.isSecondButton = false,
    this.onSecondButtonPressed = _emptyButton,
  });

  final String title;
  final String subtitle;
  final String image;
  final String buttonName;
  final VoidCallback onPressed;
  final VoidCallback? onSecondButtonPressed;
  final bool isLotti;
  final bool isSecondButton;

  static void _emptyButton() {
    // Default empty callback
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 100),
              if (isLotti)
                Lottie.asset(
                  image,
                  width: 200,
                  height: 200,
                )
              else
                Image.asset(image),
              const SizedBox(height: 20),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: TSizes.defaultSpace,
                  fontWeight: FontWeight.bold,
                ),
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
                child: ElevatedButton(
                  onPressed: () {
                    // Ensure navigation only occurs when this button is pressed
                    onPressed();
                  },
                  child: Text(buttonName),
                ),
              ),
              const SizedBox(height: TSizes.defaultSpace),
              // Conditionally render the second button
              if (isSecondButton)
                TextButton(
                  onPressed: onSecondButtonPressed,
                  child: const Text("Resend Email"),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
