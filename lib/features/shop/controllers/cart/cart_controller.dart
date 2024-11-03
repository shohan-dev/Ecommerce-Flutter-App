import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  static CartController get instance => Get.find();

  final RxList<Map<String, dynamic>> cartList = <Map<String, dynamic>>[].obs;

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
    print("Start fetching cart");

    if (user == null) {
      print("No user is currently logged in.");
      isLoading.value = false; // Set loading to false if no user
      return;
    }
    // if no cart found then create empty cart
    if (cartList.isEmpty) {
      cartList.add({});
    }

    try {
      _db
          .collection("Users")
          .doc(user?.uid)
          .snapshots()
          .listen((documentSnapshot) {
        if (documentSnapshot.exists) {
          final cartListData =
              documentSnapshot.data()?['cart'] as List<dynamic>?;

          if (cartListData != null) {
            cartList.value = List<Map<String, dynamic>>.from(cartListData);
            print("Cart list => $cartList");
          } else {
            print("No cart information available.");
          }
        } else {
          print("User document does not exist.");
        }
      });
    } catch (e) {
      print("An error occurred while fetching cart: $e");
    } finally {
      isLoading.value = false; // Ensure loading is set to false after attempt
    }
  }

  void addToCart(product, selectedColor, selectedSize, quantity) async {
    try {
      print("start");
      // Double to int conversion
      final price = product['price'];
      final priceConvertStrToInt = double.parse(price);
      final totalPrice = quantity * priceConvertStrToInt;

      print("Price => $price");

      final cartData = {
        'brand': product['brand'],
        'name': product['name'],
        'color': selectedColor,
        'size': selectedSize,
        'quantity': quantity,
        'totalPrice': totalPrice
      };

      print("first");
      // Reference to the user's document in Firestore
      final userDocRef =
          FirebaseFirestore.instance.collection("Users").doc(user?.uid);
      print("second");
      // Check if the "cart" field exists
      final docSnapshot = await userDocRef.get();
      print("third");
      if (docSnapshot.exists) {
        // Document exists, update the cart field
        await userDocRef.set({
          "cart": FieldValue.arrayUnion([cartData])
        }, SetOptions(merge: true));

        print("fourth");
      } else {
        print("fifth");
        // Document does not exist, create it with the cart field
        await userDocRef.set({
          "cart": [cartData]
        });
        print("sixth");
      }
    } catch (e) {
      print("An error occurred while updating the cart: $e");
    }
  }
}
