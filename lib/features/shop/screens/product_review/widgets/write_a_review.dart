import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartshop/common/widget/sizebox/t_sizebox_btw_items.dart';
import 'package:smartshop/features/shop/controllers/review/review_controller.dart';
import 'package:smartshop/features/shop/models/product_models.dart';

class WriteReviewForm extends StatelessWidget {
  WriteReviewForm({Key? key, required this.product}) : super(key: key);

  final WriteReviewController controller =
      Get.put(WriteReviewController()); // Initialize controller

  final ProductModels product;

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Write a Review",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold)), // Bolder text
        backgroundColor: Theme.of(context).primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: Center(
        child: Card(
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Rate Your Experience",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: dark
                              ? Colors.white
                              : Theme.of(context).primaryColor,
                        ),
                  ),
                  const SizedBox(height: 20), // More space for better layout
                  Obx(() => Column(
                        children: [
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            child: Slider(
                              value: controller.rating.value,
                              onChanged: (newRating) {
                                controller.rating.value = newRating;
                              },
                              min: 1,
                              max: 5,
                              divisions: 30,
                              label: controller.rating.value
                                  .toStringAsFixed(1), // Show rating as label

                              activeColor: Theme.of(context).primaryColor,
                              inactiveColor: Colors.grey.withOpacity(0.5),
                            ),
                          ),
                          const SizedBox(
                              height: 10), // Space between slider and text
                          Text(
                            'Current Rating: ${controller.rating.value.toStringAsFixed(1)}',
                            style: TextStyle(
                              fontSize: 16,
                              color: dark ? Colors.white : Colors.black54,
                            ),
                          ),
                        ],
                      )),
                  const TSizeboxBtwItems(),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Your Review",
                      labelStyle: TextStyle(
                          color: dark
                              ? Colors.white
                              : Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w500), // Slightly bolder label
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            BorderSide(color: Theme.of(context).primaryColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                            color: Theme.of(context).primaryColor, width: 2.0),
                      ),
                      suffixIcon: Icon(Icons.comment,
                          color: Theme.of(context).primaryColor),
                    ),
                    maxLines: 4,
                    onChanged: (value) {
                      controller.reviewText.value = value;
                    },
                  ),
                  const TSizeboxBtwItems(),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (product.id != null) {
                          controller.submitReview(product.id!);
                        } else {
                          // Handle the case where product.id is null
                          Get.snackbar('Error', 'Product ID is null');
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 5, // Added elevation for a shadow effect
                        backgroundColor: Theme.of(context).primaryColor,
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        "Submit Review",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold), // Bolder text
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
