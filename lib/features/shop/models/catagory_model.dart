import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  String id;
  String name;
  String image;
  String parentId;
  bool isFeatured;

  CategoryModel({
    required this.id,
    required this.name,
    required this.image,
    required this.isFeatured,
    this.parentId = '',
  });

  /// Empty Helper Function
  static CategoryModel empty() => CategoryModel(
        id: '',
        name: '',
        image: '',
        isFeatured: false,
        parentId: '',
      );

  // convert model to json object
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'image': image,
      'isFeatured': isFeatured,
      'parentId': parentId,
    };
  }

  // convert json object to model
  factory CategoryModel.fromsnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();
    if (data != null) {
      return CategoryModel(
        id: document.id,
        name: data['name'] ?? '',
        image: data['image'] ?? '',
        isFeatured: data['isFeatured'] ?? false,
        parentId: data['parentId'] ?? '',
      );
    } else {
      // Handle the case where data is null, e.g., return an empty model or throw an exception
      return CategoryModel.empty();
    }
  }
}
