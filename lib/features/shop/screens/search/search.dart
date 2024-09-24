import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

class SearchProductScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchProductScreen> {
  final TextEditingController _controller = TextEditingController();
  String _searchQuery = "";
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      if (_debounce?.isActive ?? false) _debounce!.cancel();
      _debounce = Timer(const Duration(milliseconds: 300), () {
        setState(() {
          _searchQuery = _controller.text.trim();
        });
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Real-time Search Firestore'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Enter text to search',
              ),
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: (_searchQuery.isNotEmpty)
                    ? FirebaseFirestore.instance
                        .collection('Shop_Products') // Collection name
                        .where('title',
                            isGreaterThanOrEqualTo:
                                _searchQuery) // Start of query
                        .where('title',
                            isLessThanOrEqualTo:
                                '$_searchQuery\uf8ff') // End of query
                        .snapshots()
                    : FirebaseFirestore.instance
                        .collection('Shop_Products')
                        .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(child: Text('No results found.'));
                  }

                  final results = snapshot.data!.docs;

                  return ListView.builder(
                    itemCount: results.length,
                    itemBuilder: (context, index) {
                      final data =
                          results[index].data() as Map<String, dynamic>;
                      return ListTile(
                        title: Text(data[
                            'title']), // Assuming 'title' is the field you want to display
                        // You can add more fields here, like images or prices
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
