import 'package:flutter/material.dart';
import 'package:smartshop/features/personailzation/controllers/profile_update/name_update_cotroller.dart';
import 'package:smartshop/utils/constants/sizes.dart';
import 'package:smartshop/utils/helpers/helper_functions.dart';
import 'package:smartshop/utils/validators/validation.dart';

class TNameUpdateScreen extends StatelessWidget {
  const TNameUpdateScreen({
    super.key,
    required this.firstName,
    required this.lastName,
  });

  final String firstName, lastName;
  final IconData icon = Icons.person;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    // Initialize controllers with passed initial values
    NameUpdateCotroller.instance.firstName.text = firstName;
    NameUpdateCotroller.instance.lastName.text = lastName;

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
              "Name",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(
              height: TSizes.defaultSpace,
            ),
            Text(
              "Enter your new name to keep your profile up to date.",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(
              height: TSizes.appBarHeight,
            ),
            Form(
              key: NameUpdateCotroller.instance.nameUpdateFormKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  TextFormField(
                    controller: NameUpdateCotroller.instance.firstName,
                    validator: (value) =>
                        TValidator.validateEmptyText(value, "First Name"),
                    decoration: InputDecoration(
                      prefixIcon: Icon(icon),
                      labelText: "First Name",
                    ),
                  ),
                  const SizedBox(
                    height: TSizes.defaultSpace,
                  ),
                  TextFormField(
                    controller: NameUpdateCotroller.instance.lastName,
                    validator: (value) =>
                        TValidator.validateEmptyText(value, "Last Name"),
                    decoration: InputDecoration(
                      prefixIcon: Icon(icon),
                      labelText: "Last Name",
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: TSizes.defaultSpace,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  NameUpdateCotroller.instance.updateName();
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
