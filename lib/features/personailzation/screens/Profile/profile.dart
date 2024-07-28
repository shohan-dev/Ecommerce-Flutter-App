import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/common/widget/appbar/appbar.dart';
import 'package:t_store/common/widget/images/t_circular_image.dart';
import 'package:t_store/common/widget/sizebox/t_sizebox_btw_items.dart';
import 'package:t_store/common/widget/texts/section_heading.dart';
import 'package:t_store/features/shop/screens/Profile/widgets/profile_menu.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/constants/sizes.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
              const Center(
                  child: TCircularImage(
                image: TImages.user,
                height: 100,
                width: 100,
              )),
              TextButton(
                  onPressed: () {},
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

              const TProfileMenu(
                title: 'Name',
                value: 'Md Sabbir Roshid Shohan',
              ),
              const TProfileMenu(
                title: 'Username',
                value: 'shohan',
              ),
              const TSizeboxBtwItems(),
              const Divider(),
              const TSizeboxBtwItems(),
              //-- Personal Information
              const TSectionHeading(
                title: "Personal Information",
                showActionButton: false,
              ),
              const TProfileMenu(
                title: 'User ID',
                value: '496523',
                icon: Iconsax.copy,
              ),
              const TProfileMenu(
                title: 'E-mail',
                value: 'shohan@gmail.com',
              ),
              const TProfileMenu(
                title: 'Phone Number',
                value: '+8801758496771',
              ),
              const TProfileMenu(
                title: 'Gender',
                value: 'Male',
              ),
              const TProfileMenu(
                title: 'Date of Birth',
                value: '11 July, 2001',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
