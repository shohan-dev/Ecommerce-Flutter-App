import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smartshop/utils/constants/image_strings.dart'; // Import for ByteData

// Model classes
class BrandModel {
  final String id;
  final String image;
  final String name;

  BrandModel({required this.id, required this.image, required this.name});
}

class ProductAttributeModel {
  final String name;
  final List<String> values;

  ProductAttributeModel({required this.name, required this.values});
}

class ProductVariationModel {
  final String id;
  final int stock;
  final double price;
  final double salePrice;
  final String image;
  final String description;
  final Map<String, String> attributeValues;

  ProductVariationModel({
    required this.id,
    required this.stock,
    required this.price,
    required this.salePrice,
    required this.image,
    required this.description,
    required this.attributeValues,
  });
}

class ProductModel {
  final String id;
  final String title;
  final int stock;
  final double price;
  final bool isFeatured;
  final String thumbnail;
  final String description;
  final BrandModel brand;
  final List<String> images;
  final double salePrice;
  final String sku;
  final String categoryId;
  final List<ProductAttributeModel> productAttributes;
  final List<ProductVariationModel> productVariations;
  final String productType;

  ProductModel({
    required this.id,
    required this.title,
    required this.stock,
    required this.price,
    required this.isFeatured,
    required this.thumbnail,
    required this.description,
    required this.brand,
    required this.images,
    required this.salePrice,
    required this.sku,
    required this.categoryId,
    required this.productAttributes,
    required this.productVariations,
    required this.productType,
  });
}

// Service class to handle product operations
class ProductService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;

  // Helper function to upload image from assets
  Future<String> uploadImageFromAssets(
      String assetPath, String storagePath) async {
    try {
      // Load image from assets
      final ByteData byteData = await rootBundle.load(assetPath);
      final Uint8List imageData = byteData.buffer.asUint8List();

      // Create a reference to the storage path
      final storageRef = storage.ref().child(storagePath);

      // Upload the file to Firebase Storage
      final uploadTask = storageRef.putData(imageData);
      final snapshot = await uploadTask.whenComplete(() {});
      final downloadUrl = await snapshot.ref.getDownloadURL();

      return downloadUrl;
    } catch (e) {
      print("Error uploading image from assets: $e");
      return '';
    }
  }

  // Function to save product to Firestore
  Future<void> saveProductToFirestore(ProductModel product) async {
    try {
      final productRef = firestore.collection('Products').doc(product.id);

      // Upload product thumbnail
      String thumbnailUrl = await uploadImageFromAssets(
          'assets/images/thumbnail.jpg',
          'Product All/${product.id}/thumbnail.jpg');

      // Upload product images
      List<String> imageUrls = [];
      for (var imagePath in product.images) {
        String imageUrl = await uploadImageFromAssets(imagePath,
            'Product All/${product.id}/image_${product.images.indexOf(imagePath)}.jpg');
        imageUrls.add(imageUrl);
      }

      // Upload brand image
      String brandImageUrl = await uploadImageFromAssets(
          'assets/images/brand.jpg',
          'Product All/brands/${product.brand.id}.jpg');

      // Process product variations
      List<Map<String, dynamic>> variationData = [];
      for (var variation in product.productVariations) {
        String variationImageUrl = await uploadImageFromAssets(
            'assets/images/${variation.id}.jpg',
            'Product All/variations/${variation.id}.jpg');
        variationData.add({
          'id': variation.id,
          'stock': variation.stock,
          'price': variation.price,
          'salePrice': variation.salePrice,
          'image': variationImageUrl,
          'description': variation.description,
          'attributeValues': variation.attributeValues,
        });
      }

      // Prepare product data for Firestore
      final productData = {
        'title': product.title,
        'stock': product.stock,
        'price': product.price,
        'isFeatured': product.isFeatured,
        'thumbnail': thumbnailUrl,
        'description': product.description,
        'brand': {
          'id': product.brand.id,
          'image': brandImageUrl,
          'name': product.brand.name,
        },
        'images': imageUrls,
        'salePrice': product.salePrice,
        'sku': product.sku,
        'categoryId': product.categoryId,
        'productAttributes': product.productAttributes
            .map((attr) => {
                  'name': attr.name,
                  'values': attr.values,
                })
            .toList(),
        'productVariations': variationData,
        'productType': product.productType,
      };

      // Save product data to Firestore
      await productRef.set(productData);
    } catch (e) {
      print("Error saving product to Firestore: $e");
    }
  }
}

// Usage Example (in another file):
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialize Firebase
  final productService = ProductService();

  final products = [
    ProductModel(
      id: '003',
      title: 'Tshirt for Men',
      stock: 25,
      price: 8000,
      isFeatured: false,
      thumbnail: TImages.productImage64,
      description:
          "This is beautiful color collar Tshirt. Full Front and back is plain. It is comfortable in every season. Official and business holders can also use this tshirt for their dress code in offices and can print their logo easily.",
      brand: BrandModel(
        id: 'brand001',
        image: TImages.zaraLogo,
        name: 'ZARA',
      ),
      images: [
        TImages.productImage60,
        TImages.productImage61,
        TImages.productImage62,
        TImages.productImage63,
      ],
      salePrice: 30,
      sku: 'ABR4568',
      categoryId: '16',
      productAttributes: [
        ProductAttributeModel(name: 'Size', values: ['EU34', 'EU32']),
        ProductAttributeModel(name: 'Color', values: ['Green', 'Red', 'Blue']),
      ],
      productVariations: [
        ProductVariationModel(
          id: 'var001',
          stock: 10,
          price: 38000,
          salePrice: 30000,
          image: TImages.productImage60,
          description:
              'This is a Product variation description. It is a Leather brown Jacket.',
          attributeValues: {'Color': 'Red', 'Size': 'EU34'},
        ),
      ],
      productType: 'ProductType.single',
    ),
    ProductModel(
      id: '123',
      title: 'Tshirt for Men',
      stock: 25,
      price: 8000,
      isFeatured: false,
      thumbnail: TImages.productImage64,
      description:
          "This is beautiful color collar Tshirt. Full Front and back is plain. It is comfortable in every season. Official and business holders can also use this tshirt for their dress code in offices and can print their logo easily.",
      brand: BrandModel(
        id: 'brand001',
        image: TImages.zaraLogo,
        name: 'ZARA',
      ),
      images: [
        TImages.productImage60,
        TImages.productImage61,
        TImages.productImage62,
        TImages.productImage63,
      ],
      salePrice: 30,
      sku: 'ABR4568',
      categoryId: '16',
      productAttributes: [
        ProductAttributeModel(name: 'Size', values: ['EU34', 'EU32']),
        ProductAttributeModel(name: 'Color', values: ['Green', 'Red', 'Blue']),
      ],
      productVariations: [
        ProductVariationModel(
          id: 'var001',
          stock: 10,
          price: 38000,
          salePrice: 30000,
          image: TImages.productImage60,
          description:
              'This is a Product variation description. It is a Leather brown Jacket.',
          attributeValues: {'Color': 'Red', 'Size': 'EU34'},
        ),
      ],
      productType: 'ProductType.single',
    ),
    ProductModel(
      id: '234',
      title: 'Tshirt for Men',
      stock: 25,
      price: 8000,
      isFeatured: false,
      thumbnail: TImages.productImage64,
      description:
          "This is beautiful color collar Tshirt. Full Front and back is plain. It is comfortable in every season. Official and business holders can also use this tshirt for their dress code in offices and can print their logo easily.",
      brand: BrandModel(
        id: 'brand001',
        image: TImages.zaraLogo,
        name: 'ZARA',
      ),
      images: [
        TImages.productImage60,
        TImages.productImage61,
        TImages.productImage62,
        TImages.productImage63,
      ],
      salePrice: 30,
      sku: 'ABR4568',
      categoryId: '16',
      productAttributes: [
        ProductAttributeModel(name: 'Size', values: ['EU34', 'EU32']),
        ProductAttributeModel(name: 'Color', values: ['Green', 'Red', 'Blue']),
      ],
      productVariations: [
        ProductVariationModel(
          id: 'var001',
          stock: 10,
          price: 38000,
          salePrice: 30000,
          image: TImages.productImage60,
          description:
              'This is a Product variation description. It is a Leather brown Jacket.',
          attributeValues: {'Color': 'Red', 'Size': 'EU34'},
        ),
      ],
      productType: 'ProductType.single',
    ),
  ];













  print("Starting to save products to Firestore...");
  // Save all products to Firestore
  for (var product in products) {
    await productService.saveProductToFirestore(product);
    // print number of iteration
    print("Product ${products.indexOf(product) + 1} saved!");
    print("Product ID: ${product.id}");
  }
  print("Products saved successfully!");
}
