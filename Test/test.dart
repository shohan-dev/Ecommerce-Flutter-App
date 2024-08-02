import 'package:flutter/material.dart';
import 'package:t_store/common/widget/custom_shape/containers/circular_container.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('ChoiceChip Example')),
        body: Center(child: 
        ChoiceChip(label: Text("data"), 
        
        
        
        
        selected: true)),
      ),
    );
  }
}
