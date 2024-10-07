import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:smartshop/data/repositories/wishlist/wishlist_repositories.dart';
import 'package:smartshop/features/shop/models/product_models.dart';

class WishlistController extends GetxController {
  static WishlistController get instance => Get.find();

  final isLoading = false.obs;
  final RxList<ProductModels> wishlistProducts = <ProductModels>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchWishlist();
  }

  void fetchWishlist() async {
    Get.put(WishlistRepositories());
    final FirebaseFirestore _db = FirebaseFirestore.instance;
    final User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      print("No user is currently logged in.");
      return;
    }

    // Listen for changes to the user's document
    _db
        .collection("Users")
        .doc(user.uid)
        .snapshots()
        .listen((documentSnapshot) {
      if (documentSnapshot.exists) {
        final List<String> wishlistIds =
            List<String>.from(documentSnapshot['wishlist']);
        updateWishlist(wishlistIds);
      } else {
        print("User document does not exist.");
      }
    });
  }

  void updateWishlist(List<String> wishlistIds) async {
    try {
      final productList =
          await WishlistRepositories.instance.getAllWishlist(wishlistIds);
      wishlistProducts.assignAll(productList);
    } catch (e) {
      print("Error fetching wishlist products: $e");
    }
  }
}
