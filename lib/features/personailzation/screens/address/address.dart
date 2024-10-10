import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:smartshop/common/widget/appbar/appbar.dart';
import 'package:smartshop/features/personailzation/controllers/address/address_controller.dart';
import 'package:smartshop/features/personailzation/screens/address/add_new_address.dart';
import 'package:smartshop/features/personailzation/screens/address/widgets/single_address.dart';
import 'package:smartshop/utils/constants/colors.dart';
import 'package:smartshop/utils/constants/sizes.dart';

class UserAddressScreen extends StatelessWidget {
  const UserAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final addressController = Get.put(AddressController());
    final address = addressController.addressList;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: TColors.primary,
          child: const Icon(
            Iconsax.add,
            color: TColors.white,
          ),
          onPressed: () {
            Get.to(() => const AddNewAddressScreen());
          }),
      appBar: TAppBar(
        showBackArrow: true,
        title: Text(
          "Addresses",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              Obx(
                () => ListView.builder(
                  shrinkWrap: true,
                  itemCount: address.length,
                  itemBuilder: (context, index) {
                    final isActive = address[index]['isActive'];
                    return GestureDetector(
                      onTap: () {
                        
                        addressController.toggleAddressStatus(index);
                      },
                      child: TSingleAddress(
                        name: address[index]['name'],
                        phoneNumber: address[index]['phoneNumber'],
                        address: address[index]['address'],
                        selectedAddress: isActive,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
