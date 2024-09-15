import 'package:carousel_slider/carousel_controller.dart';
import 'package:get/get.dart';
import 'package:smartshop/common/widget/snackbar/snackbar.dart';
import 'package:smartshop/data/repositories/banners/banners_repositories.dart';
import 'package:smartshop/features/shop/models/banner_models.dart';

class BannersController extends GetxController {
  static BannersController get to => Get.find();
  final isLoading = false.obs;
  final carousalCurrentIndex = 0.obs;
  final RxList<BannerModels> banners = <BannerModels>[].obs;
  final CarouselController carouselController = CarouselController();

  @override
  void onInit() {
    fetchBanners();
    super.onInit();
  }

  void updatePageIndex(index) {
    carousalCurrentIndex.value = index;
  }

  Future<void> fetchBanners() async {
    try {
      isLoading.value = true;
      final bannerRepo = Get.put(BannersRepositories());
      final bannerList = await bannerRepo.getAllBanners();
      banners.value = bannerList;
    } catch (e) {
      TLoaders.errorSnackBar(title: "oh Snap!", message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
