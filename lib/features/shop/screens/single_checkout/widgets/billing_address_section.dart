import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:smartshop/common/widget/texts/section_heading.dart';
import 'package:smartshop/features/personailzation/screens/address/address.dart';
import 'package:smartshop/features/shop/controllers/single_checkout/single_checkout_controller.dart';
import 'package:smartshop/utils/constants/sizes.dart';

class TAddressSectionSingle extends StatelessWidget {
  const TAddressSectionSingle({super.key});

  @override
  Widget build(BuildContext context) {
    final address = SingleCheckoutController.instance.addressList;

    // Define button title based on whether the address list is empty
    var changenameupdate = address.isEmpty ? "Add" : "Change";

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TSectionHeading(
          title: "Shipping Address",
          buttonTitle: changenameupdate,
          onPressed: () {
            Get.to(() => const UserAddressScreen());
          },
        ),
        // If address is empty, show a message to add an address
        if (address.isEmpty) ...[
          Text(
            "Please add address",
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: Colors.red),
          ),
        ] else ...[
          // Address details
          Row(
            children: [
              const Icon(Iconsax.user, color: Colors.grey, size: 16),
              const SizedBox(width: TSizes.spaceBtwItems),
              Obx(
                () => Text(
                  address[0]["name"],
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ],
          ),
          const SizedBox(height: TSizes.spaceBtwItems / 2),
          Row(
            children: [
              const Icon(Iconsax.call, color: Colors.grey, size: 16),
              const SizedBox(width: TSizes.spaceBtwItems),
              Obx(
                () => Text(
                  address[0]["phoneNumber"],
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ],
          ),
          const SizedBox(height: TSizes.spaceBtwItems / 2),
          Row(
            children: [
              const Icon(Icons.location_history, color: Colors.grey, size: 16),
              const SizedBox(width: TSizes.spaceBtwItems),
              Expanded(
                child: Obx(
                  () => Text(
                    address[0]["address"],
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}
