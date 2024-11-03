import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'dart:async';

class CartController extends GetxController {
  static CartController get instance => Get.find();

  final RxList<Map<String, dynamic>> cartList = <Map<String, dynamic>>[].obs;
  var totalPrice = <Map<String, dynamic>>[].obs;
  final isLoading = false.obs;

  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final User? user = FirebaseAuth.instance.currentUser;
  Timer? _debounceTimer;

  @override
  void onInit() {
    super.onInit();
    fetchCart();
  }

  void fetchCart() {
    isLoading.value = true;
    print("Fetching cart...");

    if (user == null) {
      print("No user is currently logged in.");
      isLoading.value = false;
      return;
    }

    _db.collection("Users").doc(user?.uid).snapshots().listen(
      (documentSnapshot) {
        if (documentSnapshot.exists) {
          final cartListData =
              documentSnapshot.data()?['cart'] as List<dynamic>?;

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
      },
      onError: (error) {
        print("An error occurred while fetching cart: $error");
        isLoading.value = false;
      },
    );
  }

  void updateQuantity(int index, int newQuantity, double price) {
    if (index < 0 || index >= cartList.length) return;
    if (newQuantity > 10) return;

    var product = cartList[index];
    var totalPrice = newQuantity * price;
    totalPrice = double.parse(totalPrice.toStringAsFixed(2));

    var updatedProduct = {
      ...product,
      'quantity': newQuantity,
      'totalPrice': totalPrice,
    };

    // Update local state immediately for smooth user interaction
    cartList[index] = updatedProduct;

    // Debounce Firestore update to avoid frequent network calls
    _debounceTimer?.cancel(); // Cancel any existing timer
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      _updateFirestoreCart();
    });
  }

  void _updateFirestoreCart() {
    if (user == null) return;

    _db.collection("Users").doc(user?.uid).update({
      'cart':
          cartList.map((item) => item).toList(), // Ensure proper serialization
    }).then((_) {
      print("Cart updated successfully in Firestore.");
    }).catchError((error) {
      print("Failed to update cart in Firestore: $error");
    });
  }

  @override
  void onClose() {
    _debounceTimer?.cancel();
    super.onClose();
  }

  double getTotalPrice(List<Map<String, dynamic>> totalPrice) {
    return totalPrice
        .map((item) => item['totalPrice'] as double)
        .fold(0.0, (sum, price) => sum + price);
  }
}
