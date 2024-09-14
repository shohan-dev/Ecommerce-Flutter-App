import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:get/get.dart';
import 'package:smartshop/features/personailzation/controllers/profile_update/gender_update_cotroller.dart';
import 'package:smartshop/utils/constants/sizes.dart';
import 'package:smartshop/utils/helpers/helper_functions.dart';

class TGenderUpdateScreen extends StatelessWidget {
  const TGenderUpdateScreen({
    Key? key,
    required this.fieldValue,
  }) : super(key: key);

  final String fieldValue;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final GenderUpdateCotroller controller = Get.put(GenderUpdateCotroller());

    // Initialize the controller's selectedValue
    if (controller.selectedValue.isEmpty) {
      controller.updateSelectedValue(fieldValue);
    }

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: dark ? Colors.white : Colors.black),
        backgroundColor: dark ? Colors.black : Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Gender",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(
              height: TSizes.defaultSpace,
            ),
            Text(
              "Update Your Gender",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(
              height: TSizes.appBarHeight - 10,
            ),
            Obx(
              () => DropdownButtonFormField<String>(
                value: controller.selectedValue.value.isEmpty ? null : controller.selectedValue.value,
                onChanged: (value) {
                  if (value != null) {
                    controller.updateSelectedValue(value);
                  }
                },
                items: <String>['Male', 'Female'].map((String gender) {
                  return DropdownMenuItem<String>(
                    value: gender,
                    child: Text(gender),
                  );
                }).toList(),
                decoration: const InputDecoration(
                  prefixIcon: Icon(Iconsax.user),
                  labelText: "Gender",
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value == null || value.isEmpty
                    ? 'Please select a value'
                    : null,
              ),
            ),
            const SizedBox(
              height: TSizes.defaultSpace,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  controller.updateGender();
                  
                },
                child: const Text("Save"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
