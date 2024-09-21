import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  String name;
  String image;
  bool isFeatured;

  CategoryModel({
    required this.name,
    required this.image,
    required this.isFeatured,
  });

  /// Empty Helper Function
  static CategoryModel empty() => CategoryModel(
        name: '',
        image: '',
        isFeatured: false,
      );

  // convert model to json object
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'image': image,
      'isFeatured': isFeatured,
    };
  }

  // convert json object to model
  factory CategoryModel.fromsnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();
    if (data != null) {
      return CategoryModel(
        name: data['name'] ?? '',
        image: data['image'] ?? '',
        isFeatured: data['isFeatured'] ?? false,
      );
    } else {
      // Handle the case where data is null, e.g., return an empty model or throw an exception
      return CategoryModel.empty();
    }
  }
}
