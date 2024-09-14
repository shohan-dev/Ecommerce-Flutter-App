import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:smartshop/common/widget/effect/shimmer_effect.dart';
import 'package:smartshop/common/widget/images/t_circular_image.dart';
import 'package:smartshop/features/personailzation/controllers/user_controllers.dart';
import 'package:smartshop/utils/constants/colors.dart';
import 'package:smartshop/utils/constants/image_strings.dart';

class TUserProfileTiles extends StatelessWidget {
  const TUserProfileTiles({
    super.key,
    required this.name,
    required this.email,
    this.onPressed,
  });

  final String name;
  final String email;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return ListTile(
      leading: const TCircularImage(image: TImages.user),
      title: Obx(() {
        if (controller.isLoading.value) {
          return const TShimmerEffect(
            height: 15,
          );
        }
        return Text(
          name,
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .apply(color: TColors.white),
        );
      }),
      subtitle: Obx(() {
        if (controller.isLoading.value) {
          return const TShimmerEffect(
            height: 15,
          );
        }
        return Text(
          email,
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .apply(color: TColors.white),
        );
      }),
      trailing: IconButton(
        onPressed: onPressed,
        icon: const Icon(Iconsax.edit),
        color: TColors.white,
      ),
    );
  }
}
