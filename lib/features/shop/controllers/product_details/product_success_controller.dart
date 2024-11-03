import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:smartshop/features/shop/models/product_models.dart';

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
      var totalOrder = 1;

      // orderDate convert to string and make it only date
      var orderDate = DateTime.now().toString().substring(0, 10);

      // var address = AddressController.instance.addressList[0]['address'];
      var address = await fetchAddress_active();

      final totalPrice = product.price!.toInt() * orderQuantity;

      // Define the order info
      final orderInfo = {
        "productName": product.title,
        "productPrice": "\$${product.price}",
        "productImage": product.images![0],
        "productSku": product.sku,
        "productColor": selectedColor,
        "productSize": selectedSize,
        "category": product.category,
        "orderDate": orderDate,
        "orderStatus": "Processing",
        "orderTotal": totalOrder,
        "orderQuantity": 1,
        "orderAddress": address,
        "orderId": DateTime.now().millisecondsSinceEpoch.toString(),
        "orderPaymentMethod": "Razorpay",
        "totalPrice": "\$$totalPrice",
      };

      // Update or create the user's document in Firestore
      await FirebaseFirestore.instance.collection("Users").doc(user.uid).set({
        "orderInfo": FieldValue.arrayUnion(
            [orderInfo]) // Use arrayUnion to add to the orderInfo array
      }, SetOptions(merge: true)); // Merge the fields
    } catch (e) {
      print("Error updating order data: $e");
      Get.snackbar('Error',
          'Failed to update order data.'); // Inform the user of the failure
      rethrow;
    }
  }

  Future<void> updateProductOrderMultiple(String selectedColor,
      String selectedSize, RxList<Map<String, dynamic>> cartList) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        Get.snackbar('Error', 'User is not authenticated.');
        return;
      }

      // Convert orderDate to a simple date string
      var orderDate = DateTime.now().toString().substring(0, 10);
      // Fetch the user's address
      var address = await fetchAddress_active();

      // Loop through each item in the cartList
      for (var item in cartList) {
        var title = item['name'] ?? 'Unknown Product';
        var price = item['price'] ?? 0.0;
        var images = item['image'][0] ?? [];
        var sku = item['productSku'] ?? 'Unknown SKU';
        var color = item['color'] ?? selectedColor;
        var size = item['size'] ?? selectedSize;
        var category = item['category'] ?? 'General';
        var orderQuantity = item['quantity'] ?? 1;

        // Ensure `images` is a non-empty list with at least one image URL
        var productImage = images.isNotEmpty ? images : 'default_image_url';

        var totalPrice = price * orderQuantity;

        // Print to debug
        print("Processing item: $item");

        // Define the order info for each item
        final orderInfo = {
          "productName": title,
          "productPrice": "\$$price",
          "productImage": productImage,
          "productSku": sku,
          "productColor": color,
          "productSize": size,
          "category": category,
          "orderDate": orderDate,
          "orderStatus": "Processing",
          "orderQuantity": orderQuantity,
          "orderAddress": address,
          "orderId": DateTime.now().millisecondsSinceEpoch.toString(),
          "orderPaymentMethod": "Razorpay",
          "totalPrice": "\$$totalPrice",
        };

        // Print to confirm order info
        print("Order Info: $orderInfo");

        // Add each order info to the user's order collection
        await FirebaseFirestore.instance.collection("Users").doc(user.uid).set({
          "orderInfo": FieldValue.arrayUnion([orderInfo])
        }, SetOptions(merge: true));
      }
      // remove all cart data in the user's document
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(user.uid)
          .set({"cart": FieldValue.delete()}, SetOptions(merge: true));

    } catch (e) {
      print("Error updating order data: $e");
      Get.snackbar('Error', 'Failed to update order data.');
      rethrow;
    }
  }

  Future<String?> fetchAddress_active() async {
    final FirebaseFirestore _db = FirebaseFirestore.instance;
    final user = FirebaseAuth.instance.currentUser;

    final snapshot = await _db.collection("Users").doc(user?.uid).get();

    if (snapshot.exists) {
      final data = snapshot.data();
      print("Snapshot ===================>>>>>>> $data");

      // Check if the address field exists and filter for active addresses
      if (data?['address'] != null) {
        final activeAddresses = (data!['address'] as List)
            .where((address) => address['isActive'] == true)
            .toList();

        if (activeAddresses.isNotEmpty) {
          // Get the first active address
          final String orderAddress = activeAddresses[0]['address'];

          print("Order Address: $orderAddress");

          // Return the order address
          return orderAddress;
        } else {
          print("No active addresses found.");
          return null; // No active addresses
        }
      } else {
        print("No address field found.");
        return null; // No address field
      }
    } else {
      print("User document does not exist.");
      return null; // User document does not exist
    }
  }
}
