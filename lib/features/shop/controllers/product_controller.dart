import 'package:get/get.dart';
import 'package:smartshop/features/shop/models/product_models.dart';
import 'package:smartshop/data/repositories/product/product_repositories.dart';
import 'package:smartshop/common/widget/snackbar/snackbar.dart';

class ProductController extends GetxController {
  static ProductController get instance => Get.find();
  late final ProductRepositories productRepo;
  final isLoading = false.obs;
  final RxList<ProductModels> featuredProducts = <ProductModels>[].obs;
  final RxList<ProductModels> categoryProducts = <ProductModels>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Initialize the repository instance
    productRepo = Get.put(ProductRepositories());
    fetchFeaturedProducts();
  }

  Future<void> fetchFeaturedProducts() async {
    try {
      isLoading.value = true;
      final products = await productRepo.getFeaturedProducts();
      // Update the observable list with fetched data
      featuredProducts.value = products;
    } catch (e) {
      // Handle errors and display appropriate messages
      TLoaders.errorSnackBar(title: "Error", message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }
  // Category Product
  Future<void> fetchCategoryProduct(categoryName) async {
    try {
      isLoading.value = true;
      final products = await productRepo.getCategoryProduct(categoryName);
      // Update the observable list with fetched data
      categoryProducts.value = products;
    } catch (e) {
      // Handle errors and display appropriate messages
      TLoaders.errorSnackBar(title: "Error", message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

}
