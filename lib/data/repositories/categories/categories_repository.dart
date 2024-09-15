
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:smartshop/features/shop/models/catagory_model.dart';
import 'package:smartshop/utils/exceptions/firebase_exceptions.dart';

class CategoriesRepository extends GetxController {
  static CategoriesRepository get to => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<CategoryModel>> getAllCategories() async {
    try {
      final snapshot = await _db.collection('Categories').get();
      final list =
          snapshot.docs.map((doc) => CategoryModel.fromsnapshot(doc)).toList();
      return list;
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
