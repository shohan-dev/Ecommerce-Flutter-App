import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Firestore Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _loading = false;
  String _message = '';

  @override
  void initState() {
    super.initState();
    _fetchAndSaveData();
  }

  Future<void> _fetchAndSaveData() async {
    setState(() {
      _loading = true;
      _message = 'Fetching data...';
    });

    final firestore = FirebaseFirestore.instance;
    final baseUrl =
        'https://dummyjson.com/products/'; // Base URL for individual products

    try {
      for (int i = 1; i <= 5; i++) {
        final url = '$baseUrl$i'; // Create URL for each product
        final response = await http.get(Uri.parse(url));

        if (response.statusCode == 200) {
          final data = json.decode(response.body);

          // Save each product to Firestore
          await firestore
              .collection('dummy_data')
              .doc(data['id'].toString())
              .set(data);
          print('Product $i saved successfully');
        } else {
          print('Failed to load product $i');
        }
      }

      setState(() {
        _loading = false;
        _message = 'Data saved successfully';
      });
    } catch (e) {
      setState(() {
        _loading = false;
        _message = 'Error: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firestore Example'),
      ),
      body: Center(
        child: _loading ? CircularProgressIndicator() : Text(_message),
      ),
    );
  }
}
