import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:smartshop/features/shop/models/product_models.dart';
import 'package:smartshop/navigation_menu.dart';

class ProductSuccessController extends GetxController {
  static ProductSuccessController get instance => Get.find();

  Future<void> updateProductOrder(
      String selectedColor, String selectedSize, ProductModels product) async {
    if (selectedColor.isEmpty || selectedSize.isEmpty) {
      Get.snackbar(
          'Error', 'Color and size cannot be empty.'); // Display a snackbar
      return;
    }

    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        Get.snackbar('Error',
            'User is not authenticated.'); // Handle user not being authenticated
        return;
      }
      var orderQuantity = 1;
      

      final totalPrice =  product.price!.toInt() *orderQuantity;

      // Define the order info
      final orderInfo = {
        "productName": product.title,
        "productPrice": product.price,
        "productImage": product.images![0],
        "productSku": product.sku,
        "productColor": selectedColor,
        "productSize": selectedSize,
        "orderDate": DateTime.now(),
        "orderStatus": "Processing",
        "orderTotal": product.price,
        "orderQuantity": 1,
        "orderAddress": "123 Main St, New York, NY 10001",
        "orderId": DateTime.now().millisecondsSinceEpoch.toString(),
        "orderPaymentMethod": "Stripe",
        "totalPrice": totalPrice,

      };

      // Update or create the user's document in Firestore
      await FirebaseFirestore.instance.collection("Users").doc(user.uid).set({
        "orderInfo": FieldValue.arrayUnion(
            [orderInfo]) // Use arrayUnion to add to the orderInfo array
      }, SetOptions(merge: true)); // Merge the fields

      Get.snackbar('Success', 'Order updated successfully!'); // Confirm success
      Get.offAll(
          () => const NavigationMenuPage()); // Navigate to the home screen
    } catch (e) {
      print("Error updating order data: $e");
      Get.snackbar('Error',
          'Failed to update order data.'); // Inform the user of the failure
      throw e;
    }
  }
}
