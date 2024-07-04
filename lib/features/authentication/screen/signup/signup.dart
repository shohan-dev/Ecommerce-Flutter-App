import 'package:flutter/material.dart';
import 'package:t_store/utils/constants/text_strings.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text(TTexts.signupTitle),
        ],
      ),
    );
  }
}
