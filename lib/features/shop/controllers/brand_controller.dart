import 'package:get/get.dart';
import 'package:smartshop/common/widget/snackbar/snackbar.dart';
import 'package:smartshop/data/repositories/brands/brands_repository.dart';
import 'package:smartshop/features/shop/models/brand_models.dart';

class BrandController extends GetxController {
  static BrandController get instance => Get.find();
  final isLoading = false.obs;
  final RxList<BrandModels> brands = <BrandModels>[].obs;
  final RxList<BrandModels> popularBrands = <BrandModels>[].obs;

  @override
  void onInit() {
    fetchBrands();
    super.onInit();
  }

  Future<void> fetchBrands() async {
    try {
      isLoading.value = true;
      final brandRepo = Get.put(BrandsRepository());
      final brandList = await brandRepo.getAllCBrands();
      final popularBrandList = await brandRepo.popularBrands();
      brands.value = brandList;
      popularBrands.value = popularBrandList;
    } catch (e) {
      TLoaders.errorSnackBar(title: "oh Snap!", message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
