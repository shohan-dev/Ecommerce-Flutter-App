import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingController extends GetxController {
  static OnboardingController get instance => Get.find();

  // Variables
  final pageController = PageController();
  final currentPageindex = 0.obs;

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
  void nextPage() {}

// Update Current Index & jump to the last page
  void skipPage() {}
}
