import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import 'package:get/get.dart';
import 'package:smartshop/common/widget/appbar/appbar.dart';
import 'package:smartshop/features/personailzation/controllers/address/address_controller.dart';
import 'package:smartshop/utils/constants/sizes.dart';

class AddNewAddressScreen extends StatelessWidget {
  const AddNewAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize the AddressController
    final AddressController controller = Get.put(AddressController());

    return Scaffold(
      appBar: const TAppBar(
        showBackArrow: true,
        title: Text("Add new Address"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Form(
            key: controller.formKey, // Use the global key from the controller
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Iconsax.user), labelText: "Name"),
                  onChanged: (value) => controller.name.value = value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Name cannot be empty";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: TSizes.spaceBtwInputFields),
                TextFormField(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.mobile),
                    labelText: "Phone Number",
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  maxLength: 11,
                  onChanged: (value) => controller.phoneNumber.value = value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Phone number cannot be empty";
                    }
                    if (value.length < 11) {
                      return "Phone number must be 11 digits";
                    }
                    // check if the phone number is start with 01
                    if (!value.startsWith("01")) {
                      return "Phone number must start with 01";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: TSizes.spaceBtwInputFields),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(
                            prefixIcon: Icon(Iconsax.building_31),
                            labelText: "Street"),
                        onChanged: (value) => controller.street.value = value,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Street cannot be empty";
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: TSizes.spaceBtwInputFields),
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(
                            prefixIcon: Icon(Iconsax.code),
                            labelText: "Postal Code"),
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        onChanged: (value) =>
                            controller.postalCode.value = value,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Postal code cannot be empty";
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: TSizes.spaceBtwInputFields),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(
                            prefixIcon: Icon(Iconsax.building),
                            labelText: "City"),
                        onChanged: (value) => controller.city.value = value,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "City cannot be empty";
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: TSizes.spaceBtwInputFields),
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(
                            prefixIcon: Icon(Iconsax.activity),
                            labelText: "State"),
                        onChanged: (value) => controller.state.value = value,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "State cannot be empty";
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: TSizes.spaceBtwInputFields),
                TextFormField(
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Iconsax.global), labelText: "Country"),
                  onChanged: (value) => controller.country.value = value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Country cannot be empty";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: TSizes.spaceBtwInputFields),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      controller.saveAddress(); // Call the save function
                    },
                    child: const Text("Save"),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
