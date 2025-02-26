import 'package:flutter/material.dart';
import 'package:smartshop/common/widget/custom_shape/containers/rounded_container.dart';
import 'package:smartshop/utils/constants/colors.dart';
import 'package:smartshop/utils/constants/sizes.dart';
import 'package:smartshop/utils/helpers/helper_functions.dart';

class TCuponCode extends StatelessWidget {
  const TCuponCode({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return TRoundedContainer(
      showBorder: true,
      backgroundColor: dark ? TColors.dark : TColors.white,
      padding: const EdgeInsets.only(
        top: TSizes.sm,
        bottom: TSizes.sm,
        left: TSizes.sm,
        right: TSizes.md,
      ),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              decoration: const InputDecoration(
                hintText: "Have a promo code? Enter here",
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
              ),
            ),
          ),
          SizedBox(
            width: 80,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey.withOpacity(0.2),
                  foregroundColor: dark
                      ? TColors.white.withOpacity(0.5)
                      : TColors.dark.withOpacity(0.5),
                  side: BorderSide(color: Colors.grey.withOpacity(0.1))),
              child: const Text("Apply"),
            ),
          )
        ],
      ),
    );
  }
}
