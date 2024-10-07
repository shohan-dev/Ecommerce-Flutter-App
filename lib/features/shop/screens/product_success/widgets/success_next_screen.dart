import 'package:flutter/material.dart';
import 'package:smartshop/common/widget/loader/animation_loader.dart';
import 'package:smartshop/features/shop/controllers/product_details/product_success_controller.dart';
import 'package:smartshop/features/shop/models/product_models.dart';
import 'package:smartshop/utils/constants/image_strings.dart';

class succesNextScreen extends StatelessWidget {
  const succesNextScreen({
    super.key,
    required this.selectedColor,
    required this.selectedSize,
    required this.product,
  });

  final String selectedColor;
  final String selectedSize;
  final ProductModels product;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TAnimationLoaderWidget(
              text: "Successfully Checkout",
              animation: TImages.paymentSuccessfulAnimation),
          const SizedBox(height: 20),
          // button sizebox
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Get.offAll(() => const NavigationMenuPage());
                  ProductSuccessController.instance.updateProductOrder(selectedColor, selectedSize,product);
                },
                child: const Text("Continue Shopping"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
