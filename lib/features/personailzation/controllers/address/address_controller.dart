import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:smartshop/features/shop/controllers/single_checkout/single_checkout_controller.dart';

class AddressController extends GetxController {
  static AddressController get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final User? user = FirebaseAuth.instance.currentUser;
  final RxList addressList = [].obs;

  // Form fields
  var name = ''.obs;
  var phoneNumber = ''.obs;
  var street = ''.obs;
  var postalCode = ''.obs;
  var city = ''.obs;
  var state = ''.obs;
  var country = ''.obs;
  bool isActive = false;

  // Global key for the form
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    fetchAddress();
    Get.put(SingleCheckoutController());
  }

  // Function to save the address
  Future<void> saveAddress() async {
    if (formKey.currentState!.validate()) {
      print("Saving address...");
      final addressData = {
        'name': name.value,
        'phoneNumber': phoneNumber.value,
        'isActive': isActive,
        'address':
            "${street.value}, ${city.value}, ${state.value} ${postalCode.value}, ${country.value}"
      };

      try {
        await _db.collection("Users").doc(user!.uid).update({
          'address': FieldValue.arrayUnion([addressData])
        });
        Get.back();
      } catch (e) {
        print("Error saving address: $e");
      }
    }
  }

  // fetch address
  void fetchAddress() {
    _db
        .collection("Users")
        .doc(user!.uid)
        .snapshots()
        .listen((documentSnapshot) {
      if (documentSnapshot.exists) {
        final List addresses = documentSnapshot.data()?['address'] ?? [];
        addressList.value = addresses;
      } else {
        if (kDebugMode) {
          print("User document does not exist.");
        }
      }
    });
  }

  void toggleAddressStatus(int index) {
    // First, toggle the selected address's isActive status
    addressList[index]['isActive'] = !addressList[index]['isActive'];

    // Count active addresses
    int activeCount =
        addressList.where((address) => address['isActive']).length;

    // If no addresses are active after toggle, revert the selected address
    if (activeCount == 0) {
      addressList[index]['isActive'] =
          true; // Ensure the current address stays active
    } else {
      // Deactivate all other addresses
      for (var i = 0; i < addressList.length; i++) {
        if (i != index) {
          addressList[i]['isActive'] = false;
        }
      }
    }

    // Update to Firestore
    _db.collection("Users").doc(user!.uid).update({
      'address': addressList,
    });

    update(); // Use this to refresh the UI
    addressList.refresh(); // Refresh the address list
  }
}
