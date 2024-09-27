// Controller for managing search query state and fetching data from Firestore
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:smartshop/features/shop/models/product_models.dart';

class SearchControllerData extends GetxController {
  var searchQuery = ''.obs;
  final RxList<ProductModels> searchResults = <ProductModels>[].obs;
  var hasResults = false.obs; // Track if there are results
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
    //case if the query is empty
    if (query.trim().isEmpty) {
      searchQuery.value = '';
      return;
    }

    // Capitalize the first letter of each word
    searchQuery.value = _capitalizeFirstLetter(query);
  }

// capitalize the first letter of each word
  String _capitalizeFirstLetter(String text) {
    return text.split(' ').map((word) {
      if (word.isEmpty) return ''; // Handle empty words
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

        // Map the documents to ProductModels
        searchResults.value = querySnapshot.docs
            .map((doc) => ProductModels.fromJson(doc.data()))
            .toList()
            .cast<ProductModels>();

        hasResults.value = searchResults
            .isNotEmpty; // Update hasResults based on searchResults
      } catch (e) {
        if (kDebugMode) {
          print('Error fetching results: $e');
        }
      }
    } else {
      searchResults.clear();
      hasResults.value = false; // No results if the search query is empty
    }
  }

  @override
  void onClose() {
    _debounce?.cancel();
    super.onClose();
  }
}
