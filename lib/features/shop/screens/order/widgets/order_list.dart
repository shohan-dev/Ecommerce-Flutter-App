import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:smartshop/common/widget/custom_shape/containers/rounded_container.dart';
import 'package:smartshop/common/widget/images/t_circular_image.dart';
import 'package:smartshop/features/shop/controllers/order/order_controller.dart';
import 'package:smartshop/utils/constants/colors.dart';
import 'package:smartshop/utils/constants/sizes.dart';
import 'package:smartshop/utils/helpers/helper_functions.dart';

class TOrderListItems extends StatelessWidget {
  const TOrderListItems({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrderController()); // controller
    final dark = THelperFunctions.isDarkMode(context);
    final backgroundColor =
        dark ? const Color(0xFF1A1A1A) : const Color(0xFFF9F9F9);
    final textColor = dark ? Colors.white : const Color(0xFF333333);
    const primaryColor = Color(0xFF4A90E2);
    const errorColor = Color(0xFFE57373);

    return Obx(() {
      // Check if loading
      if (controller.isLoading.value) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }

      final orderlist = controller.orderList;

      // If no orders, display a message
      if (orderlist.isEmpty) {
        return Center(
          child: Text(
            'No orders available',
            style: TextStyle(color: textColor),
          ),
        );
      }

      return ListView.separated(
        itemCount: orderlist.length,
        separatorBuilder: (_, index) =>
            const SizedBox(height: TSizes.spaceBtwItems),
        itemBuilder: (_, index) => TRoundedContainer(
          showBorder: true,
          padding: const EdgeInsets.all(TSizes.md),
          backgroundColor: backgroundColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Order Image
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12.0),
                        child: TCircularImage(
                          isNetworkImage: true,
                          width: 80,
                          height: 80,
                          image: orderlist[index]['productImage'],
                        ),
                      ),
                      const SizedBox(width: TSizes.defaultSpace),
                      // color and size
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            orderlist[index]['productColor'],
                            style: TextStyle(color: textColor),
                          ),
                          const SizedBox(height: TSizes.sm),
                          Text(
                            orderlist[index]['productSize'],
                            style: TextStyle(color: textColor),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(
                          'Quantity: ',
                          style: TextStyle(color: textColor),
                        ),
                        Text(
                          '${orderlist[index]['orderQuantity']}',
                          style: TextStyle(
                              color: textColor, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: TSizes.defaultSpace),
              // Product Details
              Text(
                orderlist[index]['productName'],
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: TSizes.sm),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '\$${orderlist[index]['totalPrice']}',
                    style: const TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: TSizes.sm),
              // Address
              Text(
                orderlist[index]['orderAddress'],
                style: TextStyle(color: textColor),
              ),
              const SizedBox(height: TSizes.sm),
              // Order Details
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Order ID: #${orderlist[index]['orderId']}',
                          style: TextStyle(color: textColor),
                        ),
                        Text(
                          'Order Date: ${orderlist[index]['orderDate']}',
                          style: TextStyle(color: textColor),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  // Status Badge
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: TColors.primary,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      orderlist[index]['orderStatus'],
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: TSizes.md),
              // Action Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {}, // Implement action
                      icon: const Icon(Iconsax.trash),
                      label: const Text('Cancel'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: errorColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: TSizes.md),
              // Add some visual separation
              Divider(
                color: Colors.grey.shade400,
                thickness: 1,
              ),
            ],
          ),
        ),
      );
    });
  }
}
