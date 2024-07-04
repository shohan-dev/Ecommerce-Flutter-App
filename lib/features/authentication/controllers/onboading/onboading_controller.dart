import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/features/authentication/screen/login/login.dart';

class OnboardingController extends GetxController {
  static OnboardingController get instance => Get.find();

  // Variables
  final pageController = PageController();
  final currentPageindex = 0.obs;
  var isLoading = false.obs;

// Update Current Index when Page Scroll
  void updatePageIndicator(index) {
    currentPageindex.value = index;
  }

// Jump to the specific dot selected page
  void dotNavigationClick(index) {
    currentPageindex.value = index;
    pageController.jumpTo(index);
  }

// Update Current Index & jump to next page
  void nextPage() async {
    if (currentPageindex.value == 2) {
      isLoading.value = true; // Start loading animation
      await Future.delayed(const Duration(milliseconds: 500));
      isLoading.value = false; // Stop loading animation
      Get.off(const LoginPage()); // Navigate to LoginPage
    } else {
      currentPageindex.value = currentPageindex.value + 1;
      pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

// Update Current Index & jump to the last page
  void skipPage() {
    Get.off(const LoginPage());
  }
}
