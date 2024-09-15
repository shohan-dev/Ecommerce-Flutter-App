import 'package:cloud_firestore/cloud_firestore.dart';

// --- Brand Category Model ---
class BrandCategoryModel {
  final String brandId;
  final String categoryId;

  BrandCategoryModel({
    required this.brandId,
    required this.categoryId,
  });

  Map<String, dynamic> toMap() {
    return {
      'brandId': brandId,
      'categoryId': categoryId,
    };
  }
}

// --- List of Brand-Category Relations ---
final List<BrandCategoryModel> brandCategories = [
  BrandCategoryModel(brandId: '1', categoryId: '1'),
  BrandCategoryModel(brandId: '1', categoryId: '8'),
  BrandCategoryModel(brandId: '1', categoryId: '9'),
  BrandCategoryModel(brandId: '1', categoryId: '10'),
  BrandCategoryModel(brandId: '2', categoryId: '1'),
  BrandCategoryModel(brandId: '2', categoryId: '8'),
  BrandCategoryModel(brandId: '2', categoryId: '9'),
  BrandCategoryModel(brandId: '2', categoryId: '10'),
  BrandCategoryModel(brandId: '3', categoryId: '1'),
  BrandCategoryModel(brandId: '3', categoryId: '8'),
  BrandCategoryModel(brandId: '3', categoryId: '9'),
  BrandCategoryModel(brandId: '3', categoryId: '10'),
  BrandCategoryModel(brandId: '4', categoryId: '1'),
  BrandCategoryModel(brandId: '4', categoryId: '8'),
  BrandCategoryModel(brandId: '4', categoryId: '9'),
  BrandCategoryModel(brandId: '4', categoryId: '10'),
  BrandCategoryModel(brandId: '5', categoryId: '15'),
  BrandCategoryModel(brandId: '5', categoryId: '2'),
  BrandCategoryModel(brandId: '6', categoryId: '3'),
  BrandCategoryModel(brandId: '6', categoryId: '16'),
  BrandCategoryModel(brandId: '7', categoryId: '2'),
  BrandCategoryModel(brandId: '8', categoryId: '5'),
  BrandCategoryModel(brandId: '8', categoryId: '11'),
  BrandCategoryModel(brandId: '8', categoryId: '12'),
  BrandCategoryModel(brandId: '8', categoryId: '13'),
  BrandCategoryModel(brandId: '9', categoryId: '5'),
  BrandCategoryModel(brandId: '9', categoryId: '11'),
  BrandCategoryModel(brandId: '9', categoryId: '12'),
  BrandCategoryModel(brandId: '9', categoryId: '13'),
];

// --- Firestore Upload Logic ---
Future<void> uploadBrandCategoryRelationsToFirebase() async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Upload Brand-Category Relations
  for (BrandCategoryModel brandCategory in brandCategories) {
    await firestore.collection('BrandCategories').add(brandCategory.toMap());
  }
}
