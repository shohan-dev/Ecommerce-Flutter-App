import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class SingleCheckoutController extends GetxController {
  static SingleCheckoutController get instance => Get.find();

  final RxList<Map<String, dynamic>> addressList = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchAddress();
    
  }

  void fetchAddress() {
    print("Start fetching address");
    final FirebaseFirestore _db = FirebaseFirestore.instance;
    final User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      print("No user is currently logged in.");
      return;
    }

    _db
        .collection("Users")
        .doc(user.uid)
        .snapshots()
        .listen((documentSnapshot) {
      if (documentSnapshot.exists) {
        final addressListData = documentSnapshot.data()?['address'];

        print("Address data: $addressListData");

        // Ensure addressListData is a list
        if (addressListData is List) {
          // Filter for isActive = true
          final List<Map<String, dynamic>> activeAddressList = addressListData
              .where((address) =>
                  address is Map<String, dynamic> &&
                  address['isActive'] == true)
              .cast<Map<String, dynamic>>() // Cast to the desired type
              .toList();

          // Update the observable list
          addressList.value = activeAddressList;
          print("End fetching address");
          print("Address List updated: $addressList");
        } else {
          print("Address data is not a list.");
        }
      } else {
        print("User document does not exist.");
      }
    });
  }
}
