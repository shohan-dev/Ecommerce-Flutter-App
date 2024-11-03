import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
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
    isLoading.value = true;

    // Listen for changes to the user's document
    _db
        .collection("Users")
        .doc(user.uid)
        .snapshots()
        .listen((documentSnapshot) {
      if (documentSnapshot.exists) {
        // Ensure wishlistIds defaults to an empty list if not found
        final List<String> wishlistIds =
            List<String>.from(documentSnapshot.data()?['wishlist'] ?? []);
        updateWishlist(wishlistIds);
        isLoading.value = false;
      } else {
        print("User document does not exist.");
        isLoading.value = false;
      }
    });
  }

  void updateWishlist(List<String> wishlistIds) async {
    if (wishlistIds.isEmpty) {
      // If the wishlistIds are empty, clear the local list and return
      wishlistProducts.clear();
      return;
    }

    try {
      final productList =
          await WishlistRepositories.instance.getAllWishlist(wishlistIds);
      wishlistProducts.value = productList;
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching wishlist products: $e");
      }
    }
  }

  void clearWishlist() async {
    final User? user = FirebaseAuth.instance.currentUser;
    final FirebaseFirestore _db = FirebaseFirestore.instance;

    if (user == null) {
      if (kDebugMode) {
        print("No user is currently logged in.");
      }
      return;
    }

    try {
      await _db.collection("Users").doc(user.uid).update({
        "wishlist": [], // Clear the wishlist by setting it to an empty array
      });
      wishlistProducts.clear(); // Clear the local list as well
    } catch (error) {
      if (kDebugMode) {
        print("Failed to clear wishlist: $error");
      }
    }
  }
}
