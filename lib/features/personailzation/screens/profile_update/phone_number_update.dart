import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:smartshop/features/personailzation/controllers/profile_update/phone_update_cotroller.dart';
import 'package:smartshop/utils/constants/sizes.dart';
import 'package:smartshop/utils/constants/text_strings.dart';
import 'package:smartshop/utils/helpers/helper_functions.dart';
import 'package:smartshop/utils/validators/validation.dart';

class TPhoneNumberUpdateScreen extends StatelessWidget {
  const TPhoneNumberUpdateScreen({
    super.key,
    required this.numbervalue,
  });

  final String numbervalue;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final controller = Get.put(PhoneUpdateCotroller());

    // Initialize controller with passed initial value
    controller.phoneNumber.text = numbervalue;

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
              "Phone Number",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(
              height: TSizes.defaultSpace,
            ),
            Text(
              "Enter your new phone number to keep your contact details up to date.",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(
              height: TSizes.appBarHeight,
            ),
            Form(
              key: controller.phoneUpdateFormKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: TextFormField(
                  controller: controller.phoneNumber,
                  validator: (value) => TValidator.validatePhoneNumber(value),
                  maxLength: 11,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter
                        .digitsOnly, // Allows only numeric input
                  ],
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Iconsax.call),
                      labelText: TTexts.phoneNo)),
            ),
            const SizedBox(
              height: TSizes.defaultSpace,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  controller.updatePhoneNumber(); // Call the update method
                },
                child: const Text("Save"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
