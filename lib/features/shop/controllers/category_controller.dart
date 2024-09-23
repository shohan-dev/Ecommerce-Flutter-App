import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:smartshop/data/repositories/categories/categories_repository.dart';
import 'package:smartshop/features/shop/models/catagory_models.dart';

class CategoryController extends GetxController {
  static CategoryController get instance => Get.find();

  final _categoryRepository = Get.put(CategoriesRepository());
  RxList<CategoryModel> allCategories = <CategoryModel>[].obs;
  RxList<CategoryModel> featuredCategories = <CategoryModel>[].obs;

  final isloading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategoriesPopular();
  }

  Future<void> fetchCategoriesPopular() async {
    try {
      isloading.value = true;
      final categories = await _categoryRepository.getAllCategories();

      // Sort categories to ensure 'kitchen-accessories' is last
      categories.sort((a, b) {
        if (a.name == 'kitchen-accessories') return 1; // Move kitchen-accessories to the end
        if (b.name == 'kitchen-accessories') return -1; // Move kitchen-accessories to the end
        return 0; // Keep original order for others
      });

      allCategories.value = categories;
      featuredCategories.value = categories.toList();
    } catch (e) {
      debugPrint('Error: $e');
    } finally {
      isloading.value = false;
    }
  }
}
