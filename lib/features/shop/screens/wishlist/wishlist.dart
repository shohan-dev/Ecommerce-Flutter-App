import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartshop/common/widget/appbar/appbar.dart';
import 'package:smartshop/common/widget/layouts/grid_layout.dart';
import 'package:smartshop/common/widget/products/product_cards/product_card_vertical.dart';
import 'package:smartshop/features/shop/controllers/wishlist/wishlist_controller.dart';
import 'package:smartshop/features/shop/models/product_models.dart';

class WishListScreen extends StatelessWidget {
  const WishListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final wishlistController = Get.put(WishlistController());

    return Scaffold(
      appBar: TAppBar(
        title: const Text("Wishlist",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
        actions: [
          Obx(() {
            return wishlistController.wishlistProducts.isNotEmpty
                ? IconButton(
                    onPressed: () {
                      _showClearWishlistDialog(context, wishlistController);
                    },
                    icon: const Icon(Icons.delete),
                  )
                : const SizedBox.shrink();
          }),
        ],
      ),
      body: Obx(() {
        if (wishlistController.isLoading.value) {
          return const Center(child: CircularProgressIndicator()); // Show loading indicator
        }

        final products = wishlistController.wishlistProducts;

        if (products.isNotEmpty) {
          return SingleChildScrollView(
            child: TGridLayout(
              itemcount: products.length,
              itemBuilder: (_, index) => _buildProductCard(products[index]),
            ),
          );
        }

        return _buildEmptyWishlist();
      }),
    );
  }

  Widget _buildEmptyWishlist() {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.favorite_border, size: 80, color: Colors.grey),
            SizedBox(height: 20),
            Text(
              "Your Wishlist is Empty",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey),
            ),
            SizedBox(height: 10),
            Text(
              "Start adding items to your wishlist to keep track of your favorites!",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductCard(ProductModels product) {
    return GestureDetector(
      onTap: () {
        // Navigation to product detail screen
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        child: TProductCardVertical(product: product),
      ),
    );
  }

  void _showClearWishlistDialog(
      BuildContext context, WishlistController wishlistController) {
    Get.defaultDialog(
      title: "Clear Wishlist",
      titleStyle: const TextStyle(
          fontWeight: FontWeight.bold, fontSize: 24, color: Colors.black),
      content: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.warning_amber, color: Colors.amber, size: 60),
          SizedBox(height: 12),
          Text(
            "Are you sure you want to clear all your wishlist?",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, color: Colors.black87),
          ),
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: () => Get.back(),
                style: TextButton.styleFrom(
                  foregroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: const BorderSide(color: Colors.blue),
                  ),
                ),
                child: const Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: () {
                  wishlistController.clearWishlist();
                  Get.back();
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text("Clear"),
              ),
            ],
          ),
        ),
      ],
      backgroundColor: Colors.white,
      barrierDismissible: true,
      radius: 12,
      titlePadding: const EdgeInsets.all(16),
      contentPadding: const EdgeInsets.all(20),
    );
  }
}
