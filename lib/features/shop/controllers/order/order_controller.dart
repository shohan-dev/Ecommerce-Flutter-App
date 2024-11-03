import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class OrderController extends GetxController {
  static OrderController get instance => Get.find();
  final RxList<Map<String, dynamic>> orderList = <Map<String, dynamic>>[].obs;

  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchOrder();
  }

  void fetchOrder() {
    isLoading.value = true;
    print("Start fetching order");
    final FirebaseFirestore _db = FirebaseFirestore.instance;
    final User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      print("No user is currently logged in.");
      isLoading.value = false; // Set loading to false if no user
      return;
    }

    try {
      _db
          .collection("Users")
          .doc(user.uid)
          .snapshots()
          .listen((documentSnapshot) {
        if (documentSnapshot.exists) {
          final orderListData =
              documentSnapshot.data()?['orderInfo'] as List<dynamic>?;

          if (orderListData != null) {
            orderList.value = List<Map<String, dynamic>>.from(orderListData);
            print("Order list => $orderList");
          } else {
            print("No order information available.");
          }
        } else {
          print("User document does not exist.");
        }
      });
    } catch (e) {
      print("An error occurred while fetching orders: $e");
    } finally {
      isLoading.value = false; // Ensure loading is set to false after attempt
    }
  }

  // delete order index
  Future<void> deleteOrder(index) async {
    final FirebaseFirestore _db = FirebaseFirestore.instance;
    final User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      print("No user is currently logged in.");
      return;
    }

    try {
      await _db.collection("Users").doc(user.uid).update({
        'orderInfo': FieldValue.arrayRemove([orderList[index]])
      });
      
    } catch (e) {
      print("An error occurred while deleting order: $e");
    }
  }
}
