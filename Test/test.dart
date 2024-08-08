import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('ChoiceChip Example')),
        body: const Center(
            child: ChoiceChip(label: Text("data"), selected: true)),
      ),
    );
  }
}
