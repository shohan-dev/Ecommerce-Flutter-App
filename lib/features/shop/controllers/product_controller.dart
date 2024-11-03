import 'package:get/get.dart';
import 'package:smartshop/features/shop/models/product_models.dart';
import 'package:smartshop/data/repositories/product/product_repositories.dart';
import 'package:smartshop/common/widget/snackbar/snackbar.dart';

class ProductController extends GetxController {
  static ProductController get instance => Get.find();
  late final ProductRepositories productRepo;
  final isLoading = false.obs;
  final RxList<ProductModels> featuredProducts = <ProductModels>[].obs;
  final RxMap<String, List<ProductModels>> categoryProductsCache =
      <String, List<ProductModels>>{}.obs;

  @override
  void onInit() {
    super.onInit();
    productRepo = Get.put(ProductRepositories());
    fetchFeaturedProducts();
  }

  // Fetch featured products
  Future<void> fetchFeaturedProducts() async {
    try {
      isLoading.value = true;
      final products = await productRepo.getFeaturedProducts();
      // featuredProducts.value = products;
      // make it random products
      featuredProducts.value = products..shuffle();
    } catch (e) {
      TLoaders.errorSnackBar(title: "Error", message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // Fetch all category products
  Future<void> fetchAllCatagoryProduct() async {
    try {
      isLoading.value = true;
      final products = await productRepo.getFeaturedProducts();
      featuredProducts.value = products;
    } catch (e) {
      TLoaders.errorSnackBar(title: "Error", message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // Fetch category products
  Future<void> fetchCategoryProduct(String categoryName) async {
    // Check if the products are already cached
    if (categoryProductsCache.containsKey(categoryName)) {
      return; // Data already fetched, no need to fetch again
    }

    try {
      isLoading.value = true;
      final products = await productRepo.getCategoryProduct(categoryName);
      categoryProductsCache[categoryName] = products; // Cache the products
    } catch (e) {
      TLoaders.errorSnackBar(title: "Error", message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // Get products for a specific category
  List<ProductModels> getCategoryProducts(String categoryName) {
    return categoryProductsCache[categoryName] ?? [];
  }
}
