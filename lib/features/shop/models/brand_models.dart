import 'package:cloud_firestore/cloud_firestore.dart';

class BrandModels {
  final bool isFeatured;
  final String image;
  final String name;

  BrandModels({
    required this.isFeatured,
    required this.image,
    required this.name,
  });
  // Empty model factory
  static BrandModels emptyBrandModel() => BrandModels(
        isFeatured: false,
        image: '',
        name: '',
      );
  // Convert model to JSON object
  Map<String, dynamic> toJson() {
    return {
      'isFeatured': isFeatured,
      'image': image,
      'name': name,
    };
  }

  // Convert JSON object to model
  factory BrandModels.fromMap(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();
    if (data != null) {
      return BrandModels(
        isFeatured: data['isFeatured'] ?? false,
        image: data['image'] ?? '',
        name: data['name'] ?? '',
      );
    } else {
      // Handle the case where data is null, e.g., return an empty model or throw an exception
      throw Exception('Document data is null');
    }
  }
}
