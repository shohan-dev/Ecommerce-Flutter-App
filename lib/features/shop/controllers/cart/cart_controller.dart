import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  static CartController get instance => Get.find();

  final RxList<Map<String, dynamic>> cartList = <Map<String, dynamic>>[].obs;
  final RxInt quantity = 1.obs; // Track quantity with RxInt
  final isLoading = false.obs;

  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final User? user = FirebaseAuth.instance.currentUser;

  @override
  void onInit() {
    super.onInit();
    fetchCart();
  }

  void fetchCart() {
    isLoading.value = true;

    if (user == null) {
      print("No user is currently logged in.");
      isLoading.value = false;
      return;
    }

    _db.collection("Users").doc(user?.uid).snapshots().listen(
        (documentSnapshot) {
      if (documentSnapshot.exists) {
        final cartListData = documentSnapshot.data()?['cart'] as List<dynamic>?;
        if (cartListData != null) {
          cartList.value = List<Map<String, dynamic>>.from(cartListData);
          print("Cart list updated: $cartList");
        } else {
          print("No cart information available.");
        }
      } else {
        print("User document does not exist.");
      }
      isLoading.value = false;
    }, onError: (error) {
      print("An error occurred while fetching cart: $error");
      isLoading.value = false;
    });
  }

  void addToCart(Map<String, dynamic> product, String selectedColor,
      String selectedSize, int quantity) async {
    try {
      final double price = double.parse(product['price'].toString());
      final double totalPrice = quantity * price;

      final cartData = {
        'brand': product['brand'],
        'name': product['title'],
        'color': selectedColor,
        'size': selectedSize,
        'quantity': quantity,
        'totalPrice': totalPrice,
      };

      final userDocRef = _db.collection("Users").doc(user?.uid);
      final docSnapshot = await userDocRef.get();

      if (docSnapshot.exists) {
        await userDocRef.set({
          "cart": FieldValue.arrayUnion([cartData]),
        }, SetOptions(merge: true));
      } else {
        await userDocRef.set({
          "cart": [cartData],
        });
      }
      print("Product added to cart successfully.");
    } catch (e) {
      print("An error occurred while updating the cart: $e");
    }
  }

  void removeFromCart(Map<String, dynamic> product) async {
    try {
      final userDocRef = _db.collection("Users").doc(user?.uid);
      await userDocRef.update({
        "cart": FieldValue.arrayRemove([product]),
      });
      cartList.remove(product); // Update local cart list
      print("Product removed from cart successfully.");
    } catch (e) {
      print("An error occurred while removing the product from the cart: $e");
    }
  }

  void clearCart() async {
    try {
      final userDocRef = _db.collection("Users").doc(user?.uid);
      await userDocRef.update({
        "cart": [],
      });
      cartList.clear(); // Clear local cart list
      print("Cart cleared successfully.");
    } catch (e) {
      print("An error occurred while clearing the cart: $e");
    }
  }

  void incrementQuantity() {
    quantity.value++;
  }

  void decrementQuantity() {
    if (quantity.value > 1) {
      quantity.value--;
    }
  }

  double getTotalPrice() {
    return cartList.fold(
        0, (sum, item) => sum + (item['totalPrice'] as double));
  }

  bool isCartEmpty() {
    return cartList.isEmpty;
  }
}
