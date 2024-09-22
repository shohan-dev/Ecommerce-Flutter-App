import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:smartshop/features/shop/models/brand_models.dart';
import 'package:smartshop/utils/exceptions/firebase_exceptions.dart';

class BrandsRepository extends GetxController {
  static BrandsRepository get to => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<BrandModels>> getAllCBrands() async {
    try {
      final snapshot = await _db.collection('Brands').get();
      final list =
          snapshot.docs.map((doc) => BrandModels.fromMap(doc)).toList();
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

  Future<List<BrandModels>> popularBrands() async {
    try {
      final snapshot = await _db.collection('Brands').limit(4).get();
      final list =
          snapshot.docs.map((doc) => BrandModels.fromMap(doc)).toList();
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

  Future<List<BrandModels>> getBrandByName() async {
    try {
      final snapshot = await _db.collection('Brands').where(
            'name',
            isEqualTo: "Fashion Fun",
      ).get();
      final list =
          snapshot.docs.map((doc) => BrandModels.fromMap(doc)).toList();
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

  // get only one brand search by name
  // Future<List<BrandModels>> getBrandByName() async {
  //   try {
  //     final snapshot = await _db
  //         .collection('Brands')
  //         .where('name', isEqualTo: "Fashion Fun")
  //         .get();
  //     final list =
  //         snapshot.docs.map((doc) => BrandModels.fromMap(doc)).toList();
  //     return list;
  //   } on FirebaseException catch (e) {
  //     // Handle Firebase-specific errors
  //     throw TFirebaseException(e.code).message;
  //   } on PlatformException catch (e) {
  //     // Handle platform-specific errors
  //     throw TFirebaseException(e.code).message;
  //   } catch (e) {
  //     // Handle all other errors
  //     throw 'An unexpected error occurred: ${e.toString()}';
  //   }
  // }
}
