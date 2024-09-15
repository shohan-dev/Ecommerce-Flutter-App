import 'package:cloud_firestore/cloud_firestore.dart';

// --- Product Category Model ---
class ProductCategoryModel {
  final String productId;
  final String categoryId;

  ProductCategoryModel({
    required this.productId,
    required this.categoryId,
  });

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'categoryId': categoryId,
    };
  }
}

// --- List of Product-Category Relations ---
final List<ProductCategoryModel> productCategories = [
  ProductCategoryModel(productId: '001', categoryId: '1'),
  ProductCategoryModel(productId: '001', categoryId: '8'),
  ProductCategoryModel(productId: '004', categoryId: '3'),
  ProductCategoryModel(productId: '002', categoryId: '3'),
  ProductCategoryModel(productId: '002', categoryId: '16'),
  ProductCategoryModel(productId: '003', categoryId: '3'),
  ProductCategoryModel(productId: '005', categoryId: '1'),
  ProductCategoryModel(productId: '005', categoryId: '8'),
  ProductCategoryModel(productId: '040', categoryId: '2'),
  ProductCategoryModel(productId: '040', categoryId: '15'),
  ProductCategoryModel(productId: '006', categoryId: '2'),
  ProductCategoryModel(productId: '007', categoryId: '4'),
  ProductCategoryModel(productId: '009', categoryId: '1'),
  ProductCategoryModel(productId: '009', categoryId: '8'),
  ProductCategoryModel(productId: '010', categoryId: '1'),
  ProductCategoryModel(productId: '010', categoryId: '8'),
  ProductCategoryModel(productId: '011', categoryId: '1'),
  ProductCategoryModel(productId: '011', categoryId: '8'),
  ProductCategoryModel(productId: '012', categoryId: '1'),
  ProductCategoryModel(productId: '012', categoryId: '8'),
  ProductCategoryModel(productId: '013', categoryId: '1'),
  ProductCategoryModel(productId: '013', categoryId: '8'),
  ProductCategoryModel(productId: '014', categoryId: '1'),
  ProductCategoryModel(productId: '014', categoryId: '9'),
  ProductCategoryModel(productId: '015', categoryId: '1'),
  ProductCategoryModel(productId: '015', categoryId: '9'),
  ProductCategoryModel(productId: '016', categoryId: '1'),
  ProductCategoryModel(productId: '016', categoryId: '9'),
  ProductCategoryModel(productId: '017', categoryId: '1'),
  ProductCategoryModel(productId: '017', categoryId: '9'),
  ProductCategoryModel(productId: '018', categoryId: '1'),
  ProductCategoryModel(productId: '018', categoryId: '10'),
  ProductCategoryModel(productId: '019', categoryId: '1'),
  ProductCategoryModel(productId: '019', categoryId: '10'),
  ProductCategoryModel(productId: '020', categoryId: '1'),
  ProductCategoryModel(productId: '020', categoryId: '10'),
  ProductCategoryModel(productId: '021', categoryId: '1'),
  ProductCategoryModel(productId: '021', categoryId: '10'),
  ProductCategoryModel(productId: '022', categoryId: '5'),
  ProductCategoryModel(productId: '022', categoryId: '11'),
  ProductCategoryModel(productId: '023', categoryId: '5'),
  ProductCategoryModel(productId: '023', categoryId: '11'),
  ProductCategoryModel(productId: '024', categoryId: '5'),
  ProductCategoryModel(productId: '024', categoryId: '11'),
  ProductCategoryModel(productId: '025', categoryId: '5'),
  ProductCategoryModel(productId: '025', categoryId: '11'),
  ProductCategoryModel(productId: '026', categoryId: '5'),
  ProductCategoryModel(productId: '026', categoryId: '12'),
  ProductCategoryModel(productId: '027', categoryId: '5'),
  ProductCategoryModel(productId: '027', categoryId: '12'),
  ProductCategoryModel(productId: '028', categoryId: '5'),
  ProductCategoryModel(productId: '028', categoryId: '12'),
  ProductCategoryModel(productId: '029', categoryId: '5'),
  ProductCategoryModel(productId: '029', categoryId: '13'),
  ProductCategoryModel(productId: '030', categoryId: '5'),
  ProductCategoryModel(productId: '030', categoryId: '13'),
  ProductCategoryModel(productId: '031', categoryId: '5'),
  ProductCategoryModel(productId: '031', categoryId: '13'),
  ProductCategoryModel(productId: '032', categoryId: '5'),
  ProductCategoryModel(productId: '032', categoryId: '13'),
  ProductCategoryModel(productId: '033', categoryId: '2'),
  ProductCategoryModel(productId: '033', categoryId: '14'),
  ProductCategoryModel(productId: '034', categoryId: '2'),
  ProductCategoryModel(productId: '034', categoryId: '14'),
  ProductCategoryModel(productId: '035', categoryId: '2'),
  ProductCategoryModel(productId: '035', categoryId: '14'),
  ProductCategoryModel(productId: '036', categoryId: '2'),
  ProductCategoryModel(productId: '036', categoryId: '14'),
  ProductCategoryModel(productId: '037', categoryId: '2'),
  ProductCategoryModel(productId: '037', categoryId: '15'),
  ProductCategoryModel(productId: '038', categoryId: '2'),
  ProductCategoryModel(productId: '038', categoryId: '15'),
  ProductCategoryModel(productId: '039', categoryId: '2'),
  ProductCategoryModel(productId: '039', categoryId: '15'),
  ProductCategoryModel(productId: '008', categoryId: '2'),
];

// --- Firestore Upload Logic ---
Future<void> uploadProductCategoryRelationsToFirebase() async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Upload Product-Category Relations
  for (ProductCategoryModel productCategory in productCategories) {
    await firestore
        .collection('ProductCategories')
        .add(productCategory.toMap());
    print("Complete Data Send");
  }
}
