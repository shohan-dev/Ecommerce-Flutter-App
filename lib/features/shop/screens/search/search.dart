import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:smartshop/common/widget/layouts/grid_layout.dart';
import 'package:smartshop/common/widget/products/product_cards/product_card_vertical.dart';
import 'package:smartshop/features/shop/controllers/product_controller.dart';
import 'package:smartshop/features/shop/controllers/search/search_controller.dart';
import 'package:smartshop/utils/constants/sizes.dart';
import 'package:smartshop/utils/helpers/helper_functions.dart';

class SearchProductScreen extends StatelessWidget {
  final SearchControllerData _searchControllerData =
      Get.put(SearchControllerData());
  final ProductController controller = ProductController.instance;

  SearchProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bool dark = THelperFunctions.isDarkMode(context);
    final ScrollController scrollController = ScrollController();

    // Scroll listener to unfocus keyboard when scrolling down
    scrollController.addListener(() {
      if (scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        FocusScope.of(context).unfocus(); // Hide keyboard when scrolling down
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('All Products'),
        iconTheme: IconThemeData(color: dark ? Colors.white : Colors.black),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          controller: scrollController,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                _buildSearchField(dark),
                const SizedBox(height: 20),
                _buildSortingDropdown(),
                const SizedBox(height: 20),
                _buildSearchResults(),
                const SizedBox(height: TSizes.spaceBtwSections),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSearchField(bool dark) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            onChanged: (value) => _searchControllerData.onSearchChanged(value),
            style: TextStyle(color: dark ? Colors.white : Colors.black),
            decoration: InputDecoration(
              labelText: 'Search',
              labelStyle: TextStyle(color: dark ? Colors.white : Colors.black),
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(100)),
                borderSide: BorderSide(color: Colors.white),
              ),
              suffixIcon: Icon(Iconsax.search_normal,
                  color: dark ? Colors.white : Colors.black),
              filled: true,
              fillColor: Colors.white.withOpacity(0.1),
            ),
          ),
        ),
        IconButton(
          icon: Icon(Iconsax.sort, color: dark ? Colors.white : Colors.black),
          tooltip: 'Sort',
          onPressed: () => _searchControllerData.toggleDropdown(),
        ),
      ],
    );
  }

  Widget _buildSortingDropdown() {
    return Obx(() {
      if (_searchControllerData.isDropdownVisible.value) {
        return SizedBox(
          width: double.infinity,
          child: DropdownButtonFormField<String>(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: const BorderSide(color: Colors.grey),
              ),
            ),
            value: _searchControllerData.selectedSortingOption.value.isNotEmpty
                ? _searchControllerData.selectedSortingOption.value
                : null,
            items: ["Name", "Higher Price", "Lower Price", "Popularity"]
                .map((value) {
              return DropdownMenuItem(value: value, child: Text(value));
            }).toList(),
            onChanged: (String? value) {
              if (value != null) {
                _searchControllerData.selectedSortingOption.value = value;
                _searchControllerData.fetchResults();
              }
            },
          ),
        );
      }
      return const SizedBox.shrink();
    });
  }

  Widget _buildSearchResults() {
    return Obx(() {
      final filteredProducts = _searchControllerData.getFilteredProducts();
      if (_searchControllerData.searchQuery.value.isEmpty) {
        return TGridLayout(
          itemcount: controller.featuredProducts.length,
          itemBuilder: (_, index) =>
              TProductCardVertical(product: controller.featuredProducts[index]),
        );
      } else if (filteredProducts.isEmpty) {
        return FutureBuilder(
          future: Future.delayed(const Duration(seconds: 2)),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return const Center(child: Text('No results found'));
            }
          },
        );
      } else {
        return TGridLayout(
          itemcount: filteredProducts.length,
          itemBuilder: (_, index) =>
              TProductCardVertical(product: filteredProducts[index]),
        );
      }
    });
  }
}
