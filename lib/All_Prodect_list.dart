import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

// Model classes
class BrandModel {
  final String id;
  final String image; // This can be a URL or asset path
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
  final String image; // This can be a URL or asset path
  final String description;
  final Map<String, String> attributeValues;

  ProductVariationModel({
    required this.id,
    required this.stock,
    required this.price,
    required this.salePrice,
    required this.image, // This can be a URL or asset path
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
  final String thumbnail; // This can be a URL or asset path
  final String description;
  final BrandModel brand;
  final List<String> images; // These can be URLs or asset paths
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
    required this.thumbnail, // This can be a URL or asset path
    required this.description,
    required this.brand,
    required this.images, // These can be URLs or asset paths
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

  // Function to save product to Firestore
  Future<void> saveProductToFirestore(ProductModel product) async {
    try {
      final productRef = firestore.collection('Products').doc(product.id);

      // Prepare product data for Firestore
      final productData = {
        'title': product.title,
        'stock': product.stock,
        'price': product.price,
        'isFeatured': product.isFeatured,
        'thumbnail': product.thumbnail,
        'description': product.description,
        'brand': {
          'id': product.brand.id,
          'image': product.brand.image,
          'name': product.brand.name,
        },
        'images': product.images,
        'salePrice': product.salePrice,
        'sku': product.sku,
        'categoryId': product.categoryId,
        'productAttributes': product.productAttributes
            .map((attr) => {
                  'name': attr.name,
                  'values': attr.values,
                })
            .toList(),
        'productVariations': product.productVariations
            .map((variation) => {
                  'id': variation.id,
                  'stock': variation.stock,
                  'price': variation.price,
                  'salePrice': variation.salePrice,
                  'image': variation.image,
                  'description': variation.description,
                  'attributeValues': variation.attributeValues,
                })
            .toList(),
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
    // 1. Laptop Pro Max
    ProductModel(
      id: '021',
      title: 'Laptop Pro Max',
      stock: 50,
      price: 1499.99,
      isFeatured: true,
      thumbnail: 'laptop_pro_max_thumbnail.jpg',
      description: 'Powerful laptop with 16GB RAM and 1TB SSD storage.',
      brand: BrandModel(
        id: 'brand021',
        image: 'techbrand_logo.jpg',
        name: 'TechBrand',
      ),
      images: [
        'laptop_pro_max_01.jpg',
        'laptop_pro_max_02.jpg',
      ],
      salePrice: 1399.99,
      sku: 'LAPTOP021',
      categoryId: '03',
      productAttributes: [
        ProductAttributeModel(name: 'RAM', values: ['16GB', '32GB']),
        ProductAttributeModel(
            name: 'Storage', values: ['512GB SSD', '1TB SSD']),
      ],
      productVariations: [],
      productType: 'ProductType.single',
    ),

    // 2. Gaming Laptop Y
    ProductModel(
      id: '022',
      title: 'Gaming Laptop Y',
      stock: 30,
      price: 1999.99,
      isFeatured: false,
      thumbnail: 'gaming_laptop_y_thumbnail.jpg',
      description: 'High-performance gaming laptop with RTX 3080 GPU.',
      brand: BrandModel(
        id: 'brand022',
        image: 'gaminggear_logo.jpg',
        name: 'GamingGear',
      ),
      images: [
        'gaming_laptop_y_01.jpg',
        'gaming_laptop_y_02.jpg',
      ],
      salePrice: 1899.99,
      sku: 'LAPTOP022',
      categoryId: '03',
      productAttributes: [
        ProductAttributeModel(name: 'GPU', values: ['RTX 3070', 'RTX 3080']),
        ProductAttributeModel(name: 'Storage', values: ['1TB SSD', '2TB SSD']),
      ],
      productVariations: [],
      productType: 'ProductType.single',
    ),

    // 3. Formal Shirt White
    ProductModel(
      id: '023',
      title: 'Formal Shirt White',
      stock: 100,
      price: 49.99,
      isFeatured: true,
      thumbnail: 'formal_shirt_white_thumbnail.jpg',
      description: 'Classic white formal shirt with slim fit design.',
      brand: BrandModel(
        id: 'brand023',
        image: 'fashionbrand_logo.jpg',
        name: 'FashionBrand',
      ),
      images: [
        'formal_shirt_white_01.jpg',
        'formal_shirt_white_02.jpg',
      ],
      salePrice: 44.99,
      sku: 'SHIRT023',
      categoryId: '02',
      productAttributes: [
        ProductAttributeModel(name: 'Size', values: ['S', 'M', 'L', 'XL']),
        ProductAttributeModel(name: 'Color', values: ['White']),
      ],
      productVariations: [],
      productType: 'ProductType.single',
    ),

    // 4. Casual T-shirt Red
    ProductModel(
      id: '024',
      title: 'Casual T-shirt Red',
      stock: 80,
      price: 29.99,
      isFeatured: false,
      thumbnail: 'casual_tshirt_red_thumbnail.jpg',
      description: 'Comfortable red t-shirt made from 100% cotton.',
      brand: BrandModel(
        id: 'brand024',
        image: 'casualwear_logo.jpg',
        name: 'CasualWear',
      ),
      images: [
        'casual_tshirt_red_01.jpg',
        'casual_tshirt_red_02.jpg',
      ],
      salePrice: 25.99,
      sku: 'TSHIRT024',
      categoryId: '02',
      productAttributes: [
        ProductAttributeModel(name: 'Size', values: ['S', 'M', 'L']),
        ProductAttributeModel(name: 'Color', values: ['Red']),
      ],
      productVariations: [],
      productType: 'ProductType.single',
    ),

    // 5. Modern Sofa Set
    ProductModel(
      id: '025',
      title: 'Modern Sofa Set',
      stock: 20,
      price: 899.99,
      isFeatured: true,
      thumbnail: 'modern_sofa_set_thumbnail.jpg',
      description: 'Luxurious 5-seater sofa set with fabric upholstery.',
      brand: BrandModel(
        id: 'brand025',
        image: 'homecomfort_logo.jpg',
        name: 'HomeComfort',
      ),
      images: [
        'modern_sofa_set_01.jpg',
        'modern_sofa_set_02.jpg',
      ],
      salePrice: 849.99,
      sku: 'SOFA025',
      categoryId: '04',
      productAttributes: [
        ProductAttributeModel(name: 'Color', values: ['Gray', 'Blue']),
        ProductAttributeModel(name: 'Material', values: ['Fabric', 'Leather']),
      ],
      productVariations: [],
      productType: 'ProductType.single',
    ),

    // 6. Wooden Coffee Table
    ProductModel(
      id: '026',
      title: 'Wooden Coffee Table',
      stock: 35,
      price: 149.99,
      isFeatured: false,
      thumbnail: 'wooden_coffee_table_thumbnail.jpg',
      description: 'Stylish wooden coffee table with a modern design.',
      brand: BrandModel(
        id: 'brand026',
        image: 'homedeco_logo.jpg',
        name: 'HomeDeco',
      ),
      images: [
        'wooden_coffee_table_01.jpg',
        'wooden_coffee_table_02.jpg',
      ],
      salePrice: 139.99,
      sku: 'TABLE026',
      categoryId: '04',
      productAttributes: [
        ProductAttributeModel(name: 'Material', values: ['Wood']),
        ProductAttributeModel(name: 'Shape', values: ['Round', 'Square']),
      ],
      productVariations: [],
      productType: 'ProductType.single',
    ),

    // 7. Yoga Mat
    ProductModel(
      id: '027',
      title: 'Yoga Mat',
      stock: 200,
      price: 19.99,
      isFeatured: false,
      thumbnail: 'yoga_mat_thumbnail.jpg',
      description: 'Eco-friendly non-slip yoga mat for comfortable exercise.',
      brand: BrandModel(
        id: 'brand027',
        image: 'fitgear_logo.jpg',
        name: 'FitGear',
      ),
      images: [
        'yoga_mat_01.jpg',
        'yoga_mat_02.jpg',
      ],
      salePrice: 17.99,
      sku: 'YOGAMAT027',
      categoryId: '05',
      productAttributes: [
        ProductAttributeModel(
            name: 'Color', values: ['Blue', 'Purple', 'Green']),
        ProductAttributeModel(
            name: 'Material', values: ['Eco-friendly rubber']),
      ],
      productVariations: [],
      productType: 'ProductType.single',
    ),

    // 8. Wireless Charger
    ProductModel(
      id: '028',
      title: 'Wireless Charger QX',
      stock: 120,
      price: 39.99,
      isFeatured: true,
      thumbnail: 'wireless_charger_qx_thumbnail.jpg',
      description: 'Fast wireless charger with 15W output.',
      brand: BrandModel(
        id: 'brand028',
        image: 'techgear_logo.jpg',
        name: 'TechGear',
      ),
      images: [
        'wireless_charger_qx_01.jpg',
        'wireless_charger_qx_02.jpg',
      ],
      salePrice: 34.99,
      sku: 'CHARGER028',
      categoryId: '05',
      productAttributes: [
        ProductAttributeModel(name: 'Color', values: ['Black', 'White']),
        ProductAttributeModel(name: 'Output', values: ['10W', '15W']),
      ],
      productVariations: [],
      productType: 'ProductType.single',
    ),

    // 9. Smartwatch X5
    ProductModel(
      id: '029',
      title: 'Smartwatch X5',
      stock: 150,
      price: 299.99,
      isFeatured: true,
      thumbnail: 'smartwatchX5_thumbnail.jpg',
      description:
          'Fitness tracking smartwatch with heart rate monitor and GPS.',
      brand: BrandModel(
        id: 'brand029',
        image: 'gearTech_logo.jpg',
        name: 'GearTech',
      ),
      images: [
        'smartwatchX5_front.jpg',
        'smartwatchX5_back.jpg',
      ],
      salePrice: 279.99,
      sku: 'WATCH029',
      categoryId: '01',
      productAttributes: [
        ProductAttributeModel(name: 'Color', values: ['Black', 'Silver']),
      ],
      productVariations: [],
      productType: 'ProductType.single',
    ),

    // 10. Noise-Canceling Headphones
    ProductModel(
      id: '030',
      title: 'Noise-Canceling Headphones',
      stock: 75,
      price: 199.99,
      isFeatured: false,
      thumbnail: 'headphones_nc_thumbnail.jpg',
      description:
          'Over-ear wireless headphones with active noise cancellation.',
      brand: BrandModel(
        id: 'brand030',
        image: 'audioGear_logo.jpg',
        name: 'AudioGear',
      ),
      images: [
        'headphones_nc_01.jpg',
        'headphones_nc_02.jpg',
      ],
      salePrice: 179.99,
      sku: 'HEADPHONES030',
      categoryId: '01',
      productAttributes: [
        ProductAttributeModel(name: 'Color', values: ['Black', 'White']),
        ProductAttributeModel(name: 'Battery Life', values: ['30 hours']),
      ],
      productVariations: [],
      productType: 'ProductType.single',
    ),
  ];

  print("Starting to save products to Firestore...");
  // Save all products to Firestore
  // var products = toysAndGames;
  for (var product in products) {
    await productService.saveProductToFirestore(product);
    print("Product ${products.indexOf(product) + 1} saved!");
    print("Product ID: ${product.id}");
  }
  print("Products saved successfully!");
}
