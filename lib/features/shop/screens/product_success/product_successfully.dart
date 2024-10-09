import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartshop/features/shop/controllers/product_details/product_success_controller.dart';
import 'package:smartshop/features/shop/models/product_models.dart';
import 'package:smartshop/utils/constants/colors.dart';

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
    final TextEditingController addressController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Product Successfully',
          style: TextStyle(
            color: TColors.white,
          ),
        ),
        backgroundColor: TColors.primary, // Use your primary color
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Product Details",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: TColors.primary,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Image.network(
                        product.images![0],
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.title,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            "Color: $selectedColor",
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            "Size: $selectedSize",
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      // price
                      const Spacer(),
                      Text(
                        "\$${product.price}",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // select your address
                  const Text(
                    "Select Your Address",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: TColors.primary,
                    ),
                  ),

                  const SizedBox(height: 12),
                  TextFormField(
                    controller: addressController,
                    decoration: InputDecoration(
                      hintText: "Street Address",
                      hintStyle: TextStyle(
                        color: Colors.grey[400],
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Colors.grey[100],
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 12),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // razorpay add
                  const Text(
                    "Payment Method",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: TColors.primary,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Row(
                    children: [
                      Icon(Icons.payment),
                      SizedBox(width: 10),
                      Text(
                        "Razorpay",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: const Text("Continue"),
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
