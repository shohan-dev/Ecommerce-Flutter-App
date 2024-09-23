import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:smartshop/common/widget/appbar/appbar.dart';
import 'package:smartshop/common/widget/layouts/grid_layout.dart';
import 'package:smartshop/common/widget/products/product_cards/product_card_vertical.dart';
import 'package:smartshop/features/shop/controllers/product_controller.dart';
import 'package:smartshop/utils/constants/sizes.dart';

class CatagoryAllProduct extends StatefulWidget {
  const CatagoryAllProduct({super.key});

  @override
  _CatagoryAllProductState createState() => _CatagoryAllProductState();
}

class _CatagoryAllProductState extends State<CatagoryAllProduct> {
  final TextEditingController _searchController = TextEditingController();
  String _searchText = '';
  String? _selectedSortingOption;
  bool _isDropdownVisible = false; // Control dropdown visibility

  @override
  Widget build(BuildContext context) {
    final product = ProductController.instance.featuredProducts
        .where((p) => p.title.contains(_searchText))
        .toList();

    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: Text("Catagory All Products",
            style: Theme.of(context).textTheme.headlineSmall),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              // Search Bar with Sort Icon Button
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
                          borderSide: BorderSide(color: Colors.grey),
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
                  width: double.infinity, // Adjust width as needed
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                    ),
                    value: _selectedSortingOption,
                    items: [
                      "Name",
                      "Higher Price",
                      "Lower Price",
                      "Sale",
                      "Newest",
                      "Popularity"
                    ].map((String value) {
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
                itemcount: product.length,
                itemBuilder: (_, index) => TProductCardVertical(
                  product: product[index],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
