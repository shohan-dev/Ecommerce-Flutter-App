import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Spacer Example'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                color: Colors.blue,
                height: 100,
                width: 100,
                child: Center(child: Text('Box 1')),
              ),
              // Spacer(), // This creates a flexible space that expands to fill the available space
              Container(
                color: Colors.red,
                height: 100,
                width: 100,
                child: Center(child: Text('Box 2')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
