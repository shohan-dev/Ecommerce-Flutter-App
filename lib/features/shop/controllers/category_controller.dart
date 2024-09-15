import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:smartshop/data/repositories/categories/categories_repository.dart';
import 'package:smartshop/features/shop/models/catagory_model.dart';

class CategoryController extends GetxController {
  static CategoryController get instance => Get.find();

  final _categoryRepository = Get.put(CategoriesRepository());
  RxList<CategoryModel> allCategories = <CategoryModel>[].obs;
  RxList<CategoryModel> featuredCategories = <CategoryModel>[].obs;

  final isloading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    try {
      isloading.value = true;
      final categories = await _categoryRepository.getAllCategories();
      allCategories.value = categories;
      featuredCategories.value = categories
          .where((element) => element.isFeatured && element.parentId.isEmpty)
          .take(categories.length) // shwoing all categories
          .toList();
    } catch (e) {
      debugPrint('Error: $e');
    } finally {
      isloading.value = false;
    }
  }
}
