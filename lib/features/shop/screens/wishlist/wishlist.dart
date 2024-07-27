import 'package:flutter/material.dart';
import 'package:t_store/common/widget/appbar/appbar.dart';
import 'package:t_store/common/widget/layouts/grid_layout.dart';
import 'package:t_store/common/widget/products/product_cards/product_card_vertical.dart';

class WishListScreen extends StatelessWidget {
  const WishListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(title: const Text("WishList"), actions: [
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {},
        ),
      ]),
      body: SingleChildScrollView(
        child: TGridLayout(
            itemcount: 9,
            itemBuilder: (_, index) => const TProductCardVertical()),
      ),
    );
  }
}
