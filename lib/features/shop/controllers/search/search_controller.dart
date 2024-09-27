import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:smartshop/features/shop/models/product_models.dart';

class SearchControllerData extends GetxController {
  var searchQuery = ''.obs;
  final RxList<ProductModels> searchResults = <ProductModels>[].obs;
  var hasResults = false.obs;
  Timer? _debounce;
  var isDropdownVisible = false.obs;
  var selectedSortingOption = ''.obs;

  @override
  void onInit() {
    super.onInit();
    debounce(searchQuery, (_) => fetchResults(),
        time: const Duration(milliseconds: 300));
  }

  void toggleDropdown() {
    isDropdownVisible.value = !isDropdownVisible.value;
  }

  void onSearchChanged(String query) {
    if (query.trim().isEmpty) {
      searchQuery.value = '';
      searchResults.clear();
      hasResults.value = false;
      return;
    }
    searchQuery.value = _capitalizeFirstLetter(query);
  }

  String _capitalizeFirstLetter(String text) {
    return text.split(' ').map((word) {
      if (word.isEmpty) return '';
      return word[0].toUpperCase() + word.substring(1);
    }).join(' ');
  }

  Future<void> fetchResults() async {
    if (searchQuery.value.isNotEmpty) {
      try {
        final querySnapshot = await FirebaseFirestore.instance
            .collection('Shop_Products')
            .where('title', isGreaterThanOrEqualTo: searchQuery.value)
            .where('title', isLessThanOrEqualTo: '${searchQuery.value}\uf8ff')
            .limit(10)
            .get();

        searchResults.value = querySnapshot.docs
            .map((doc) => ProductModels.fromJson(doc.data()))
            .toList()
            .cast<ProductModels>();

        hasResults.value = searchResults.isNotEmpty;
      } catch (e) {
        if (kDebugMode) {
          print('Error fetching results: $e');
        }
      }
    } else {
      searchResults.clear();
      hasResults.value = false;
    }
  }

  List<ProductModels> getFilteredProducts() {
    List<ProductModels> filteredProducts = searchResults.toList();

    if (selectedSortingOption.value.isNotEmpty) {
      switch (selectedSortingOption.value) {
        case "Name":
          filteredProducts.sort((a, b) => a.title.compareTo(b.title));
          break;
        case "Higher Price":
          filteredProducts.sort((a, b) => b.price!.compareTo(a.price as num));
          break;
        case "Lower Price":
          filteredProducts.sort((a, b) => a.price!.compareTo(b.price as num));
          break;
        case "Popularity":
          filteredProducts.sort((a, b) => b.rating!.compareTo(a.rating as num));
          break;
      }
    }

    return filteredProducts;
  }

  @override
  void onClose() {
    _debounce?.cancel();
    super.onClose();
  }
}
