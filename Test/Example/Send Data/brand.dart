import 'dart:typed_data';
import 'package:flutter/services.dart'; // For accessing assets as ByteData
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smartshop/utils/constants/image_strings.dart';

class BrandModel {
  final String id;
  final String imageUrl;
  final String name;
  final int productsCount;
  final bool isFeatured;

  BrandModel({
    required this.id,
    required this.imageUrl,
    required this.name,
    required this.productsCount,
    required this.isFeatured,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'imageUrl': imageUrl,
      'name': name,
      'productsCount': productsCount,
      'isFeatured': isFeatured,
    };
  }
}

Future<String> uploadBrandImage(String assetPath, String imageName) async {
  try {
    // Load image as ByteData
    final ByteData byteData = await rootBundle.load(assetPath);

    // Convert ByteData to Uint8List to upload to Firebase Storage
    final Uint8List imageData = byteData.buffer.asUint8List();

    // Reference to Firebase Storage
    final storageRef =
        FirebaseStorage.instance.ref().child('Brands/$imageName');
    final uploadTask = storageRef.putData(imageData);
    final snapshot = await uploadTask.whenComplete(() => {});
    final downloadURL = await snapshot.ref.getDownloadURL();

    print('Brand logo uploaded successfully, URL: $downloadURL');
    return downloadURL;
  } catch (e) {
    print('Failed to upload brand logo: $e');
    throw e;
  }
}

Future<void> updateBrandsInFirestore() async {
  // Ensure Firebase is initialized
  await Firebase.initializeApp();

  final firestore = FirebaseFirestore.instance;

  // List of brands with image paths, names, product counts, and isFeatured statuses
  final List<Map<String, dynamic>> brands = [
    {
      'id': '1',
      'imagePath': TImages.nikeLogo,
      'name': 'Nike',
      'productsCount': 265,
      'isFeatured': true
    },
    {
      'id': '2',
      'imagePath': TImages.adidasLogo,
      'name': 'Adidas',
      'productsCount': 95,
      'isFeatured': true
    },
    {
      'id': '8',
      'imagePath': TImages.kenwoodLogo,
      'name': 'Kenwood',
      'productsCount': 36,
      'isFeatured': false
    },
    {
      'id': '9',
      'imagePath': TImages.ikeaLogo,
      'name': 'IKEA',
      'productsCount': 36,
      'isFeatured': false
    },
    {
      'id': '5',
      'imagePath': TImages.appleLogo,
      'name': 'Apple',
      'productsCount': 16,
      'isFeatured': true
    },
    {
      'id': '10',
      'imagePath': TImages.acerlogo,
      'name': 'Acer',
      'productsCount': 36,
      'isFeatured': false
    },
    {
      'id': '3',
      'imagePath': TImages.jordanLogo,
      'name': 'Jordan',
      'productsCount': 36,
      'isFeatured': true
    },
    {
      'id': '4',
      'imagePath': TImages.pumaLogo,
      'name': 'Puma',
      'productsCount': 65,
      'isFeatured': true
    },
    {
      'id': '6',
      'imagePath': TImages.zaraLogo,
      'name': 'ZARA',
      'productsCount': 36,
      'isFeatured': true
    },
    {
      'id': '7',
      'imagePath': TImages.electronicsIcon,
      'name': 'Samsung',
      'productsCount': 36,
      'isFeatured': false
    },
  ];

  try {
    for (var brand in brands) {
      final imagePath = brand['imagePath'] as String;
      final imageName = '${brand['name']}.png';

      // Upload asset image and get URL
      final imageUrl = await uploadBrandImage(imagePath, imageName);

      // Create BrandModel with the image URL
      final brandModel = BrandModel(
        id: brand['id'] as String,
        imageUrl: imageUrl,
        name: brand['name'] as String,
        productsCount: brand['productsCount'] as int,
        isFeatured: brand['isFeatured'] as bool,
      );

      // Store the brand data in Firestore
      await firestore.collection('Brands').add(brandModel.toMap());

      print('Brand data added successfully');
    }
  } catch (e) {
    print('Failed to update brands: $e');
  }
}
