import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartshop/features/shop/controllers/product_details/product_success_controller.dart';
import 'package:smartshop/features/shop/models/product_models.dart';

class ProductSuccessfully extends StatelessWidget {
  const ProductSuccessfully({
    super.key,
    required this.selectedColor,
    required this.selectedSize,
    required this.product,
  });

  final String selectedColor, selectedSize;
  final ProductModels product;

  @override
  Widget build(BuildContext context) {
    Get.put(ProductSuccessController());
    return WillPopScope(
      onWillPop: () async {
        // Returning false to prevent back navigation
        return false;
      },
      child: const Scaffold(
          body: Column(
        children: [
          // add a design for get a textfield to enter the address
        ],
      )),
    );
  }
}

// succesNextScreen(selectedColor: selectedColor, selectedSize: selectedSize, product: product),
