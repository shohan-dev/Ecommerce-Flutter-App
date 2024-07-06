import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class NavigationMenuPage extends StatelessWidget {
  const NavigationMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationMenuConroller());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Navigation Menu'),
      ),
      bottomNavigationBar: Obx(
        () => NavigationBar(
          height: 80,
          elevation: 0,
          selectedIndex: controller.selectedindex.value,
          onDestinationSelected: (value) =>
              controller.selectedindex.value = value, // selected index page
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
              label: "Profile",
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
    Container(
      color: Colors.red,
    ),
    Container(
      color: Colors.green,
    ),
    Container(
      color: Colors.blue,
    ),
    Container(
      color: Colors.yellow,
    ),
  ];
}
