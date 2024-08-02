import 'package:flutter/material.dart';

class TSizeChip extends StatelessWidget {
  const TSizeChip({super.key});

  @override
  Widget build(BuildContext context) {
    return const ChoiceChip(label: Text("data"), selected: true);
  }
}
