import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:smartshop/common/widget/products/cart/cart_item.dart';
import 'package:smartshop/utils/constants/sizes.dart';

class ListviewItems extends StatefulWidget {
  ListviewItems({
    Key? key,
    this.showAddRemoveButton = true,
    required this.cartList,
  }) : super(key: key);

  final bool showAddRemoveButton;
  final RxList<Map<String, dynamic>> cartList;

  @override
  _ListviewItemsState createState() => _ListviewItemsState();
}

class _ListviewItemsState extends State<ListviewItems> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    // Determine the item count based on expansion
    final itemCount =
        widget.cartList.length > 2 && !_isExpanded ? 2 : widget.cartList.length;

    return Column(
      children: [
        ListView.separated(
          shrinkWrap: true,
          itemCount: itemCount,
          separatorBuilder: (_, __) => const SizedBox(
            height: TSizes.spaceBtwSections,
          ),
          itemBuilder: (_, index) => TCartItems(
            cartList: [widget.cartList[index]],
          ),
        ),
        if (widget.cartList.length > 2) // Only show if more than 2 items
          GestureDetector(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded; // Toggle expansion
              });
            },
            child: Text(
              _isExpanded ? 'Show less' : 'Show more',
              style: const TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
      ],
    );
  }
}
