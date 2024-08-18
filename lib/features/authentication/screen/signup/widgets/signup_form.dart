import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:smartshop/utils/constants/sizes.dart';
import 'package:smartshop/utils/constants/text_strings.dart';

class LoginPageForm extends StatelessWidget {
  const LoginPageForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  // controller: controller.firstNameController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.user),
                    labelText: TTexts.firstName,
                  ),
                ),
              ),
              const SizedBox(
                  width:
                      TSizes.spaceBtwInputFields), // Add spacing between fields
              Expanded(
                child: TextFormField(
                  // controller: controller.lastNameController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.user),
                    labelText: TTexts.lastName,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: TSizes.spaceBtwInputFields,
          ), // Add spacing between fields
          const TextField(
            // controller: controller.emailController,
            decoration: InputDecoration(
              prefixIcon: Icon(Iconsax.user_add),
              labelText: TTexts.username,
            ),
          ),
          const SizedBox(
            height: TSizes.spaceBtwInputFields,
          ),
          const TextField(
            decoration: InputDecoration(
              prefixIcon: Icon(Iconsax.direct),
              labelText: TTexts.email,
            ),
          ),
          const SizedBox(
            height: TSizes.spaceBtwInputFields,
          ),

          const TextField(
              // controller: controller.passwordController,
              obscureText: true,
              decoration: InputDecoration(
                  prefixIcon: Icon(Iconsax.password_check),
                  suffixIcon: Icon(Iconsax.eye_slash),
                  labelText: TTexts.password)),

          const SizedBox(
            height: TSizes.spaceBtwInputFields,
          ),
          const TextField(
              // controller: controller.passwordController,
              obscureText: true,
              decoration: InputDecoration(
                  prefixIcon: Icon(Iconsax.call), labelText: TTexts.phoneNo)),

          const SizedBox(
            height: TSizes.spaceBtwInputFields,
          ),
        ],
      ),
    );
  }
}
