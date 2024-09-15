import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:smartshop/features/shop/models/banner_models.dart';
import 'package:smartshop/utils/exceptions/firebase_exceptions.dart';

class BannersRepositories extends GetxController {
  static BannersRepositories get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<BannerModels>> getAllBanners() async {
    try {
      final snapshot = await _db
          .collection('Banners')
          .where('active', isEqualTo: true)
          .get();
      final list =
          snapshot.docs.map((doc) => BannerModels.fromSnapshot(doc)).toList();
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
