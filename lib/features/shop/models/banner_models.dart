import 'package:cloud_firestore/cloud_firestore.dart';

class BannerModels {
  final bool active;
  final String imageUrl;
  final String targetScreen;

  BannerModels({
    required this.active,
    required this.imageUrl,
    required this.targetScreen,
  });

  // Empty model factory
  static BannerModels emptyBannerModel() => BannerModels(
        active: false,
        imageUrl: '',
        targetScreen: '',
      );

  // Convert model to JSON object
  Map<String, dynamic> toJson() {
    return {
      'active': active,
      'imageUrl': imageUrl,
      'targetScreen': targetScreen,
    };
  }

  // Convert JSON object to model
  factory BannerModels.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();
    if (data != null) {
      return BannerModels(
        active: data['active'] ?? false,
        imageUrl: data['imageUrl'] ?? '',
        targetScreen: data['targetScreen'] ?? '',
      );
    } else {
      // Handle the case where data is null, e.g., return an empty model or throw an exception
      throw Exception('Document data is null');
    }
  }
}
