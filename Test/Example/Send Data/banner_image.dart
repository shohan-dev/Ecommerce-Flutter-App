import 'dart:typed_data';
import 'package:flutter/services.dart'; // For accessing assets as ByteData
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smartshop/utils/constants/image_strings.dart';

class BannerModel {
  final String imageUrl;
  final String targetScreen;
  final bool active;

  BannerModel({
    required this.imageUrl,
    required this.targetScreen,
    required this.active,
  });

  Map<String, dynamic> toMap() {
    return {
      'imageUrl': imageUrl,
      'targetScreen': targetScreen,
      'active': active,
    };
  }
}

Future<String> uploadBannerImage(String assetPath, String imageName) async {
  try {
    // Load image as ByteData
    final ByteData byteData = await rootBundle.load(assetPath);

    // Convert ByteData to Uint8List to upload to Firebase Storage
    final Uint8List imageData = byteData.buffer.asUint8List();

    // Reference to Firebase Storage
    final storageRef =
        FirebaseStorage.instance.ref().child('Banners/$imageName');
    final uploadTask = storageRef.putData(imageData);
    final snapshot = await uploadTask.whenComplete(() => {});
    final downloadURL = await snapshot.ref.getDownloadURL();

    print('Banner uploaded successfully, URL: $downloadURL');
    return downloadURL;
  } catch (e) {
    print('Failed to upload banner image: $e');
    throw e;
  }
}

Future<void> updateBannersInFirestore() async {
  // Ensure Firebase is initialized
  await Firebase.initializeApp();

  final firestore = FirebaseFirestore.instance;

  // List of banners with image paths, target screens, and active statuses
  final List<Map<String, dynamic>> banners = [
    {'imagePath': TImages.banner1, 'targetScreen': "/order", 'active': false},
    {'imagePath': TImages.banner2, 'targetScreen': "/cart", 'active': true},
    {
      'imagePath': TImages.banner3,
      'targetScreen': "/favourites",
      'active': true
    },
    {'imagePath': TImages.banner4, 'targetScreen': "/search", 'active': true},
    {'imagePath': TImages.banner5, 'targetScreen': "/settings", 'active': true},
    {
      'imagePath': TImages.banner6,
      'targetScreen': "/userAddress",
      'active': true
    },
    {
      'imagePath': TImages.banner8,
      'targetScreen': "/checkout",
      'active': false
    },
  ];

  try {
    for (var banner in banners) {
      final imagePath = banner['imagePath'] as String;
      final imageName = '${banner['targetScreen']}.png';

      // Upload asset image and get URL
      final imageUrl = await uploadBannerImage(imagePath, imageName);

      // Create BannerModel with the image URL
      final bannerModel = BannerModel(
        imageUrl: imageUrl,
        targetScreen: banner['targetScreen'] as String,
        active: banner['active'] as bool,
      );

      // Store the banner data in Firestore
      await firestore.collection('Banners').add(bannerModel.toMap());

      print('Banner data added successfully');
    }
  } catch (e) {
    print('Failed to update banners: $e');
  }
}
