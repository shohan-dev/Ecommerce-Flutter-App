import 'package:flutter/material.dart';
import 'package:smartshop/utils/constants/colors.dart';

class TSizeSelect extends StatefulWidget {
  const TSizeSelect({super.key, required this.size});

  final List<String> size; // List of size options

  @override
  _TSizeSelectState createState() => _TSizeSelectState();
}

class _TSizeSelectState extends State<TSizeSelect> {
  String? _selectedSize; // Variable to track selected size

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40, // Adjust height as needed
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.size.length,
        itemBuilder: (context, index) {
          final sizeOption = widget.size[index];
          final isSelected = sizeOption == _selectedSize;

          return Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 4.0), // Padding between containers
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedSize = sizeOption;
                });
              },
              child: Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isSelected
                      ? TColors.primary
                      : Colors.white, // Fill color for selected
                  border: Border.all(
                    color: isSelected
                        ? TColors.primary
                        : Colors.grey.shade400, // Border color
                    width: 1.5, // Border width
                  ),
                ),
                child: Center(
                  child: Text(
                    sizeOption,
                    style: TextStyle(
                      color: isSelected
                          ? Colors.white
                          : Colors.black, // Text color
                      fontWeight:
                          FontWeight.w500, // Slightly bold text for readability
                      fontSize: 14, // Font size
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
