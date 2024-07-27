import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/features/shop/screens/home/home.dart';
import 'package:t_store/features/shop/screens/profile/profile.dart';
import 'package:t_store/features/shop/screens/store/store.dart';
import 'package:t_store/features/shop/screens/wishlist/wishlist.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

class NavigationMenuPage extends StatelessWidget {
  const NavigationMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationMenuConroller());
    final darkMode = THelperFunctions.isDarkMode(context);
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Navigation Menu'),
      // ),
      bottomNavigationBar: Obx(
        () => NavigationBar(
          height: 80,
          elevation: 0,
          selectedIndex: controller.selectedindex.value,
          backgroundColor: darkMode ? TColors.black : TColors.white,
          indicatorColor: darkMode
              ? TColors.white.withOpacity(0.1)
              : TColors.black.withOpacity(0.1),

          onDestinationSelected: (value) => controller.selectedindex.value =
              value, // selected index page currently selected
          destinations: const [
            NavigationDestination(
              icon: Icon(Iconsax.home),
              label: "Home",
            ),
            NavigationDestination(
              icon: Icon(Iconsax.shop),
              label: "Store",
            ),
            NavigationDestination(
              icon: Icon(Iconsax.heart),
              label: "Wishlist",
            ),
            NavigationDestination(
              icon: Icon(Iconsax.user),
              label: "Profile",
            ),
          ],
        ),
      ),
      body: Obx(() => controller.screen[controller.selectedindex.value]),
    );
  }
}

class NavigationMenuConroller extends GetxController {
  final Rx<int> selectedindex = 0.obs;

  final screen = [
    const HomeScreen(),
    const StoreScreen(),
    const WishListScreen(),
    const ProfileScreen(),
  ];
}
