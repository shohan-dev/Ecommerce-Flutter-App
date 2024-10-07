import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:smartshop/features/shop/models/product_models.dart';
import 'package:smartshop/utils/exceptions/firebase_exceptions.dart';

class WishlistRepositories extends GetxController {
  static WishlistRepositories get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<ProductModels>> getAllWishlist(List<dynamic> wishlistIds) async {
    try {

      // Convert List<dynamic> to List<String>
      List<String> stringWishlistIds =
          wishlistIds.map((id) => id.toString()).toList();

      // Use whereIn to fetch all products matching the wishlist IDs
      final snapshot = await _db
          .collection('Shop_Products')
          .where("sku", whereIn: stringWishlistIds)
          .get();

      final list = snapshot.docs
          .map((doc) =>
              ProductModels.fromJson(doc.data()))
          .toList();

      return list;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TFirebaseException(e.code).message;
    } catch (e) {
      throw 'An unexpected error occurred: ${e.toString()}';
    }
  }
}
