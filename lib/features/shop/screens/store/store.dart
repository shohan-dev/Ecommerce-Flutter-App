import 'package:flutter/material.dart';
import 'package:t_store/common/widget/custom_shape/containers/primary_header_container.dart';
import 'package:t_store/common/widget/custom_shape/curved_edges/curved_edges_widgets.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Store'),
        ),
        body: Column(
          children: [
            TCurvedEdgesWidgets(
              child: Container(
                height: 500,
                width: 500,
                color: Colors.red,
              ),
            )
          ],
        ));
  }
}
