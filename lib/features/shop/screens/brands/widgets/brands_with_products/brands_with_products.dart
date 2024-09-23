import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:smartshop/common/widget/appbar/appbar.dart';
import 'package:smartshop/common/widget/brands/brandscardswithimage.dart';
import 'package:smartshop/common/widget/layouts/grid_layout.dart';
import 'package:smartshop/common/widget/products/product_cards/product_card_vertical.dart';
import 'package:smartshop/features/shop/controllers/brand/brand_show_product_controller.dart';
import 'package:smartshop/features/shop/models/brand_models.dart';
import 'package:smartshop/features/shop/models/product_models.dart';
import 'package:smartshop/utils/constants/sizes.dart';

class BrandsWithProducts extends StatefulWidget {
  const BrandsWithProducts({super.key, required this.brandsData});
  final BrandModels brandsData;

  @override
  _BrandsAllProductState createState() => _BrandsAllProductState();
}

class _BrandsAllProductState extends State<BrandsWithProducts> {
  final TextEditingController _searchController = TextEditingController();
  String _searchText = '';
  String? _selectedSortingOption;
  bool _isDropdownVisible = false;
  bool _isLoading = true; // Track loading state
  int _currentLimit = 10; // Track the number of products to show
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    Get.put(BrandShowProductController());
    _fetchCategoryProducts();

    // Listen for scroll events
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _loadMoreProducts();
      }
    });
  }

  Future<void> _fetchCategoryProducts() async {
    await BrandShowProductController.instance
        .fetchSingleBrandProduct(widget.brandsData.name);

    setState(() {
      _isLoading = false; // Set loading to false after fetching
    });
  }

  List<ProductModels> _getFilteredProducts() {
    final filteredProducts = BrandShowProductController
        .instance.singleBrandProduct
        .where((p) => p.title.toLowerCase().contains(_searchText.toLowerCase()))
        .toList();

    // Sort products based on the selected sorting option
    if (_selectedSortingOption != null) {
      switch (_selectedSortingOption) {
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

  Future<void> _loadMoreProducts() async {
    if (_isLoading) return; // Prevent loading if already loading
    final products = _getFilteredProducts();
    if (_currentLimit < products.length) {
      setState(() {
        _isLoading = true; // Start loading
      });

      await Future.delayed(
          const Duration(seconds: 1)); // Simulate loading delay

      setState(() {
        _currentLimit += 10; // Increase limit by 10
        _isLoading = false; // Stop loading
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final products = _getFilteredProducts();

    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: Text(
          widget.brandsData.name,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: SingleChildScrollView(
        controller: _scrollController, // Attach scroll controller
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              TBrandShowCase(
                image: widget.brandsData.image,
                brandName: widget.brandsData.name,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.search),
                        hintText: 'Search products...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _searchText = value;
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: TSizes.defaultSpace),
                  IconButton(
                    icon: const Icon(Iconsax.sort),
                    onPressed: () {
                      setState(() {
                        _isDropdownVisible =
                            !_isDropdownVisible; // Toggle dropdown
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              // Dropdown for sorting
              if (_isDropdownVisible)
                SizedBox(
                  width: double.infinity,
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                    ),
                    value: _selectedSortingOption,
                    items: ["Name", "Higher Price", "Lower Price", "Popularity"]
                        .map((String value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        _selectedSortingOption = value;
                      });
                    },
                  ),
                ),
              const SizedBox(height: TSizes.spaceBtwSections),

              // Product List

              TGridLayout(
                itemcount: _currentLimit > products.length
                    ? products.length
                    : _currentLimit,
                itemBuilder: (_, index) => TProductCardVertical(
                  product: products[index],
                ),
              ),

              // Loading Indicator at the bottom
              if (_isLoading)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: TSizes.defaultSpace),
                  child: Center(child: CircularProgressIndicator()),
                ),
              if (products.isNotEmpty) const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose(); // Dispose the scroll controller
    super.dispose();
  }
}
