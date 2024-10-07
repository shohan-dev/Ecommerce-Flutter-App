import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartshop/common/widget/appbar/appbar.dart';
import 'package:smartshop/common/widget/layouts/grid_layout.dart';
import 'package:smartshop/common/widget/products/product_cards/product_card_vertical.dart';
import 'package:smartshop/features/shop/controllers/wishlist/wishlist_controller.dart';

class WishListScreen extends StatelessWidget {
  const WishListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final product = ProductController.instance.featuredProducts;
    Get.put(WishlistController());
    final product = WishlistController.instance.wishlistProducts;

    return Scaffold(
      appBar: const TAppBar(title: Text("WishList"), actions: [
        // IconButton(
        //   icon: const Icon(Icons.add),
        //   onPressed: () {},
        // ),
      ]),
      body: SingleChildScrollView(
        child: Obx(
          () => TGridLayout(
              itemcount: product.length,
              itemBuilder: (_, index) => TProductCardVertical(
                    product: product[index],
                  )),
        ),
      ),
    );
  }
}
