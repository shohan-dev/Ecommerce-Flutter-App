import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:smartshop/features/shop/models/product_models.dart';
import 'package:smartshop/utils/exceptions/firebase_exceptions.dart';

class ProductRepositories extends GetxController {
  static ProductRepositories get instance => Get.find();
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<ProductModels>> getFeaturedProducts() async {
    try {
      final snapshot =
          await _db.collection("Shop_Products").where('id', isEqualTo: 5).get();

      return snapshot.docs.map((doc) {
        final data = doc.data(); // Correct way to get document data
        print("-----------------------------------------------  ");
        print(data);
        print("-----------------------------------------------  ");

        return ProductModels.fromJson(data);
      }).toList();
    } on FirebaseException catch (e) {
      // Handle Firebase-specific errors
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      // Handle platform-specific errors
      throw TFirebaseException(e.code).message;
    } catch (e) {
      // Handle all other errors
      throw 'An unexpected error occurred: ${e.toString()}';
    }
  }
}
