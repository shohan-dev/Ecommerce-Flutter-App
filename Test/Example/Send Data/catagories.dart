import 'dart:typed_data';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart'; // For accessing assets as ByteData
import 'package:smartshop/utils/constants/image_strings.dart';

class CategoryModel {
  final String id;
  final String image;
  final String name;
  final String? parentId;
  final bool isFeatured;

  CategoryModel({
    required this.id,
    required this.image,
    required this.name,
    this.parentId,
    required this.isFeatured,
  });

  Map<String, dynamic> toMap() {
    return {
      'image': image,
      'name': name,
      'parentId': parentId,
      'isFeatured': isFeatured,
    };
  }
}

Future<String> uploadAssetImageToStorage(
    String assetPath, String imageName) async {
  try {
    // Load image as ByteData
    final ByteData byteData = await rootBundle.load(assetPath);

    // Convert ByteData to Uint8List to upload to Firebase Storage
    final Uint8List imageData = byteData.buffer.asUint8List();

    final storageRef =
        FirebaseStorage.instance.ref().child('Categories/$imageName');
    final uploadTask = storageRef.putData(imageData);
    final snapshot = await uploadTask.whenComplete(() => {});
    final downloadURL = await snapshot.ref.getDownloadURL();

    print('Image uploaded successfully, URL: $downloadURL');
    return downloadURL;
  } catch (e) {
    print('Failed to upload image: $e');
    throw e;
  }
}

Future<void> updateCategoriesInFirestore() async {
  // Ensure Firebase is initialized
  await Firebase.initializeApp();

  final firestore = FirebaseFirestore.instance;

  // List of categories and their image asset paths
  final List<Map<String, dynamic>> categories = [
    {
      'id': '1',
      'imagePath': TImages.sportIcon,
      'name': 'Sports',
      'isFeatured': true
    },
    {
      'id': '5',
      'imagePath': TImages.furnitureIcon,
      'name': 'Furniture',
      'isFeatured': true
    },
    {
      'id': '2',
      'imagePath': TImages.electronicsIcon,
      'name': 'Electronics',
      'isFeatured': true
    },
    {
      'id': '3',
      'imagePath': TImages.clothIcon,
      'name': 'Clothes',
      'isFeatured': true
    },
    {
      'id': '4',
      'imagePath': TImages.animalIcon,
      'name': 'Animals',
      'isFeatured': true
    },
    {
      'id': '6',
      'imagePath': TImages.shoeIcon,
      'name': 'Shoes',
      'isFeatured': true
    },
    {
      'id': '7',
      'imagePath': TImages.cosmeticsIcon,
      'name': 'Cosmetics',
      'isFeatured': true
    },
    {
      'id': '8',
      'imagePath': TImages.sportIcon,
      'name': 'Sport Shoes',
      'parentId': '1',
      'isFeatured': false
    },
    {
      'id': '9',
      'imagePath': TImages.sportIcon,
      'name': 'Track Suits',
      'parentId': '1',
      'isFeatured': false
    },
    {
      'id': '10',
      'imagePath': TImages.sportIcon,
      'name': 'Sports Equipment',
      'parentId': '1',
      'isFeatured': false
    },
    {
      'id': '11',
      'imagePath': TImages.furnitureIcon,
      'name': 'Bedroom Furniture',
      'parentId': '5',
      'isFeatured': false
    },
    {
      'id': '12',
      'imagePath': TImages.furnitureIcon,
      'name': 'Kitchen Furniture',
      'parentId': '5',
      'isFeatured': false
    },
    {
      'id': '13',
      'imagePath': TImages.furnitureIcon,
      'name': 'Office Furniture',
      'parentId': '5',
      'isFeatured': false
    },
    {
      'id': '14',
      'imagePath': TImages.electronicsIcon,
      'name': 'Laptop',
      'parentId': '2',
      'isFeatured': false
    },
    {
      'id': '15',
      'imagePath': TImages.electronicsIcon,
      'name': 'Mobile',
      'parentId': '2',
      'isFeatured': false
    },
    {
      'id': '16',
      'imagePath': TImages.clothIcon,
      'name': 'Shirts',
      'parentId': '3',
      'isFeatured': false
    },
  ];

  try {
    for (var category in categories) {
      final categoryId = category['id'] as String;
      final imagePath = category['imagePath'] as String;
      final imageNamegood = category['name'] as String;
      final imageName = '$imageNamegood.png';

      // Upload asset image and get URL
      final imageUrl = await uploadAssetImageToStorage(imagePath, imageName);

      // Create CategoryModel with the image URL
      final categoryModel = CategoryModel(
        id: categoryId,
        image: imageUrl,
        name: category['name'] as String,
        parentId: category['parentId'] as String?,
        isFeatured: category['isFeatured'] as bool,
      );

      await firestore
          .collection('Categories')
          .doc(categoryId)
          .set(categoryModel.toMap(), SetOptions(merge: true));
      print('Updated category with ID: $categoryId');
    }
  } catch (e) {
    print('Failed to update categories: $e');
  }
}
