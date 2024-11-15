import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartshop/common/widget/custom_shape/containers/circular_container.dart';
import 'package:smartshop/features/shop/controllers/product_details/product_details.dart';

class TColorSelect extends StatefulWidget {
  const TColorSelect({super.key, required this.colors});

  final List<Color> colors;

  @override
  _TColorSelectState createState() => _TColorSelectState();
}

class _TColorSelectState extends State<TColorSelect> {
  Color? _selectedColor;

  @override
  Widget build(BuildContext context) {
    final selectedColorobs = Get.put(ProductDetailsController()).selectedColor;
    return SizedBox(
      height: 40, // Adjust height as needed
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.colors.length,
        itemBuilder: (context, index) {
          final color = widget.colors[index];
          final isSelected = color == _selectedColor;

          return Padding(
            padding: const EdgeInsets.all(4.0), // Padding between containers
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedColor = color;
                });
                selectedColorobs.value = color.toString();
              },
              child: TCircularContainer(
                height: 30,
                width: 30,
                backgroundColor: color,
                showCheckIcon: isSelected,
              ),
            ),
          );
        },
      ),
    );
  }
}
