import 'package:get/get.dart';
import 'package:smartshop/common/widget/snackbar/snackbar.dart';
import 'package:smartshop/data/repositories/product/product_repositories.dart';
import 'package:smartshop/features/shop/models/product_models.dart';

class BrandShowProductController extends GetxController {
  static BrandShowProductController get instance => Get.find();
  final RxList<ProductModels> singleBrandProduct = <ProductModels>[].obs;
  final isLoading = false.obs;

  // Fetch all category products
  Future<void> fetchSingleBrandProduct(brandName) async {
    try {
      isLoading.value = true;
      final productRepo = ProductRepositories();
      final products = await productRepo.getBrandAllProduct(brandName);
      singleBrandProduct.value = products;
    } catch (e) {
      TLoaders.errorSnackBar(title: "Error", message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
