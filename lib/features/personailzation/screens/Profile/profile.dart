import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:smartshop/common/widget/appbar/appbar.dart';
import 'package:smartshop/common/widget/images/t_circular_image.dart';
import 'package:smartshop/features/personailzation/controllers/profile_update/profile_controller.dart';
import 'package:smartshop/features/personailzation/screens/profile_update/date_of_birth._update.dart';
import 'package:smartshop/features/personailzation/screens/profile_update/name_update.dart';
import 'package:smartshop/features/personailzation/screens/profile_update/gender_update.dart';
import 'package:smartshop/features/personailzation/screens/profile_update/phone_number_update.dart';
import 'package:smartshop/common/widget/sizebox/t_sizebox_btw_items.dart';
import 'package:smartshop/common/widget/texts/section_heading.dart';
import 'package:smartshop/features/personailzation/controllers/user_controllers.dart';
import 'package:smartshop/features/personailzation/screens/Profile/widgets/profile_menu.dart';
import 'package:smartshop/utils/constants/sizes.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: Text(
          "Profile",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              Center(child: Obx(() {
                final networkImage = controller.user.value!.imgUrl;
                return TCircularImage(
                  image: networkImage,
                  isNetworkImage: true,
                  width: 100,
                  height: 100,
                );
              })),
              TextButton(
                  onPressed: () {
                    ProfileController.instance.updateProfilePicture();
                  },
                  child: const Text("Change Profile picture")),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              const Divider(),
              const TSizeboxBtwItems(),

              //--Profile Information
              const TSizeboxBtwItems(),
              const TSectionHeading(
                title: "Profile Information",
                showActionButton: false,
              ),

              Obx(
                () => TProfileMenu(
                  title: 'Name',
                  value: controller.user.value!.fullName,
                  ontap: () {
                    Get.to(() => TNameUpdateScreen(
                          firstName: controller.user.value!.firstName,
                          lastName: controller.user.value!.lastName,
                        ));
                  },
                ),
              ),
              TProfileMenu(
                title: 'Username',
                value: controller.user.value!.username,
                iconvisable: false,
              ),
              const TSizeboxBtwItems(),
              const Divider(),
              const TSizeboxBtwItems(),
              //-- Personal Information
              const TSectionHeading(
                title: "Personal Information",
                showActionButton: false,
              ),
              TProfileMenu(
                title: 'User ID',
                value: controller.user.value!.uid,
                icon: Iconsax.copy,
              ),
              TProfileMenu(
                title: 'E-mail',
                value: controller.user.value!.email,
                iconvisable: false,
              ),
              TProfileMenu(
                title: 'Phone Number',
                value: controller.user.value!.phone,
                ontap: () {
                  Get.to(() => TPhoneNumberUpdateScreen(
                        numbervalue: controller.user.value!.phone,
                      ));
                },
              ),

              TProfileMenu(
                title: 'Gender',
                value: controller.user.value!.gender,
                ontap: () {
                  Get.to(() => TGenderUpdateScreen(
                        fieldValue: controller.user.value!.gender,
                      ));
                },
              ),
              TProfileMenu(
                title: 'Date of Birth',
                value: controller.user.value!.date_of_birth,
                ontap: () {
                  Get.to(() => TDateOfBirthUpdate(
                        date_of_birth: controller.user.value!.date_of_birth,
                      ));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
