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
  void nextPage() {
    if (currentPageindex.value == 2) {
      print("Next page Goind");
    } else {
      currentPageindex.value = currentPageindex.value + 1;
      pageController.nextPage(
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

// Update Current Index & jump to the last page
  void skipPage() {
    currentPageindex.value = 2;
    pageController.jumpToPage(2);
  }
}
