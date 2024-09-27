import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:smartshop/common/widget/layouts/grid_layout.dart';
import 'package:smartshop/common/widget/products/product_cards/product_card_vertical.dart';
import 'package:smartshop/features/shop/controllers/product_controller.dart';
import 'package:smartshop/features/shop/controllers/search/search_controller.dart';
import 'package:smartshop/features/shop/models/product_models.dart';
import 'package:smartshop/utils/constants/sizes.dart';
import 'package:smartshop/utils/helpers/helper_functions.dart';

class SearchProductScreen extends StatefulWidget {
  SearchProductScreen({super.key});

  @override
  _SearchProductScreenState createState() => _SearchProductScreenState();
}

class _SearchProductScreenState extends State<SearchProductScreen> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final SearchControllerData _searchControllerData =
      Get.put(SearchControllerData());
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    // Add listener to detect scrolling
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        FocusScope.of(context).unfocus(); // Hide keyboard when scrolling down
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose(); // Clean up the controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool dark = THelperFunctions.isDarkMode(context);
    final controller = ProductController.instance;

    return Scaffold(
      appBar: AppBar(
        title: const Text('All Products'),
        iconTheme: IconThemeData(color: dark ? Colors.white : Colors.black),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context)
              .unfocus(); // Unfocus the TextField when tapping outside
        },
        child: SingleChildScrollView(
          controller: _scrollController, // Attach ScrollController
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        focusNode: _focusNode,
                        onChanged: (value) {
                          _searchControllerData.onSearchChanged(value);
                        },
                        style: TextStyle(
                            color: dark ? Colors.white : Colors.black),
                        decoration: InputDecoration(
                          labelText: 'Search',
                          labelStyle: TextStyle(
                              color: dark ? Colors.white : Colors.black),
                          border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(100)),
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          suffixIcon: Icon(
                            Iconsax.search_normal,
                            color: dark ? Colors.white : Colors.black,
                          ),
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.1),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Iconsax.sort,
                        color: dark ? Colors.white : Colors.black,
                      ),
                      tooltip: 'Sort',
                      onPressed: () {
                        _searchControllerData.toggleDropdown();
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Sorting Dropdown
                Obx(() {
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
                        value: _searchControllerData
                                .selectedSortingOption.value.isNotEmpty
                            ? _searchControllerData.selectedSortingOption.value
                            : null,
                        items: [
                          "Name",
                          "Higher Price",
                          "Lower Price",
                          "Popularity"
                        ].map((String value) {
                          return DropdownMenuItem(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          if (value != null) {
                            _searchControllerData.selectedSortingOption.value =
                                value;
                            _searchControllerData
                                .fetchResults(); // Update results when sorting changes
                          }
                        },
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                }),

                // Search Results
                Obx(() {
                  final filteredProducts = _getFilteredProducts();
                  if (_searchControllerData.searchQuery.value.isEmpty) {
                    return Obx(
                      () => TGridLayout(
                        itemcount: controller.featuredProducts.length,
                        itemBuilder: (_, index) => TProductCardVertical(
                          product: controller.featuredProducts[index],
                        ),
                      ),
                    );
                  } else if (filteredProducts.isEmpty) {
                    return FutureBuilder(
                      future: Future.delayed(const Duration(seconds: 2)),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Column(
                            children: [
                              SizedBox(height: 20),
                              Center(child: CircularProgressIndicator()),
                            ],
                          );
                        } else {
                          return const Column(
                            children: [
                              SizedBox(height: 20),
                              Center(child: Text('No results found')),
                            ],
                          );
                        }
                      },
                    );
                  } else {
                    return Column(
                      children: [
                        const SizedBox(height: 20),
                        TGridLayout(
                          itemcount: filteredProducts.length,
                          itemBuilder: (_, index) => TProductCardVertical(
                            product: filteredProducts[index],
                          ),
                        ),
                      ],
                    );
                  }
                }),
                const SizedBox(height: 6),
                const SizedBox(height: TSizes.spaceBtwSections),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Get filtered products based on the search query and sorting option
  List<ProductModels> _getFilteredProducts() {
    final filteredProducts = _searchControllerData.searchResults
        .where((p) => p.title
            .toLowerCase()
            .contains(_searchControllerData.searchQuery.value.toLowerCase()))
        .toList();

    // Sort products based on the selected sorting option
    if (_searchControllerData.selectedSortingOption.value.isNotEmpty) {
      switch (_searchControllerData.selectedSortingOption.value) {
        case "Name":
          filteredProducts.sort((a, b) => a.title.compareTo(b.title));
          break;
        case "Higher Price":
          filteredProducts.sort((a, b) {
            final aPrice = double.tryParse(a.price.toString()) ?? 0.0;
            final bPrice = double.tryParse(b.price.toString()) ?? 0.0;
            return bPrice.compareTo(aPrice);
          });
          break;
        case "Lower Price":
          filteredProducts.sort((a, b) {
            final aPrice = double.tryParse(a.price.toString()) ?? 0.0;
            final bPrice = double.tryParse(b.price.toString()) ?? 0.0;
            return aPrice.compareTo(bPrice);
          });
          break;
        case "Popularity":
          filteredProducts.sort((a, b) {
            final aRating = double.tryParse(a.rating.toString()) ?? 0.0;
            final bRating = double.tryParse(b.rating.toString()) ?? 0.0;
            return bRating.compareTo(aRating);
          });
          break;
      }
    }

    return filteredProducts;
  }
}
