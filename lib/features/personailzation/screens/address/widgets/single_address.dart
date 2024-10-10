import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:smartshop/common/widget/custom_shape/containers/rounded_container.dart';
import 'package:smartshop/utils/constants/colors.dart';
import 'package:smartshop/utils/constants/sizes.dart';
import 'package:smartshop/utils/helpers/helper_functions.dart';

class TSingleAddress extends StatelessWidget {
  const TSingleAddress(
      {super.key,
      required this.selectedAddress,
      required this.name,
      required this.phoneNumber,
      required this.address});

  final bool selectedAddress;
  final String name, phoneNumber, address;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return SingleChildScrollView(
      child: GestureDetector(
        onForcePressPeak: (details) {
          print('Force press peak: $details');
        },
        child: TRoundedContainer(
          padding: const EdgeInsets.all(TSizes.md),
          width: double.infinity,
          showBorder: true,
          backgroundColor: selectedAddress
              ? TColors.primary.withOpacity(0.5)
              : Colors.transparent,
          borderColor: selectedAddress
              ? Colors.transparent
              : dark
                  ? TColors.darkGrey
                  : TColors.grey,
          margin: const EdgeInsets.only(bottom: TSizes.spaceBtwItems),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Iconsax.user,
                        color: Colors.grey,
                        size: 16,
                      ),
                      const SizedBox(
                        width: TSizes.spaceBtwItems,
                      ),
                      Text(
                        name,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwItems / 2,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Iconsax.call,
                        color: Colors.grey,
                        size: 16,
                      ),
                      const SizedBox(
                        width: TSizes.spaceBtwItems,
                      ),
                      Text(
                        phoneNumber,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwItems / 2,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Iconsax.location,
                        color: Colors.grey,
                        size: 16,
                      ),
                      const SizedBox(
                        width: TSizes.spaceBtwItems,
                      ),
                      Expanded(
                        child: Wrap(
                          children: [
                            Text(
                              address,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
