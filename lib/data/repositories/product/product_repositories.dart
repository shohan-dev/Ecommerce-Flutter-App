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
      final snapshot = await _db
          .collection("Shop_Products")
          .where("isPopularProducts", isEqualTo: true)
          .limit(20)
          .get();

      return snapshot.docs.map((doc) {
        final data = doc.data(); // Correct way to get document data

        // lengeth of the data
        // print("data length : ${data.length}");

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

  // unique brands
  Future<List<String>> getUniqueBrands() async {
    final uniqueBrands = <String>{}; // Using a Set to store unique brand names

    try {
      // Limit the number of documents to fetch
      final snapshot = await _db.collection("Shop_Products").get();

      // Iterate through the documents and add unique brands to the set
      for (var doc in snapshot.docs) {
        final brand =
            doc.data()['brand'] as String?; // Access the brand field directly
        if (brand != null && brand.isNotEmpty) {
          uniqueBrands.add(brand);
        }
      }
    } catch (e) {
      print("Error fetching brands: $e");
    }

    return uniqueBrands.toList(); // Convert Set to List before returning
  }

  // unique category
  Future<List<String>> getUniqueCategory() async {
    final uniqueCategory =
        <String>{}; // Using a Set to store unique brand names

    try {
      // Limit the number of documents to fetch
      final snapshot = await _db.collection("Shop_Products").get();

      // Iterate through the documents and add unique brands to the set
      for (var doc in snapshot.docs) {
        final category = doc.data()['category']
            as String?; // Access the brand field directly
        if (category != null && category.isNotEmpty) {
          uniqueCategory.add(category);
        }
      }
      print("uniqueCategory : $uniqueCategory");
    } catch (e) {
      print("Error fetching category: $e");
    }

    return uniqueCategory.toList(); // Convert Set to List before returning
  }
}
