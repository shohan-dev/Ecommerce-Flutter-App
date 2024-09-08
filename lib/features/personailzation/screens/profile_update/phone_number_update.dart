import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smartshop/utils/constants/sizes.dart';
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
                child: TextFormField(
                  controller: TextEditingController(text: numbervalue),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(11),
                  ],
                  validator: (value) =>
                      TValidator.validateEmptyText(value, "Phone Number"),
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.phone),
                    labelText: "Phone",
                  ),
                ),
              ),
              const SizedBox(
                height: TSizes.defaultSpace,
              ),
              SizedBox(
                width: double.infinity,
                child:
                    ElevatedButton(onPressed: () {}, child: const Text("Save")),
              )
            ],
          ),
        ));
  }
}
