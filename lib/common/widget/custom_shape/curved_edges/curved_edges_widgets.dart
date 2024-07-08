import 'package:flutter/material.dart';
import 'package:t_store/common/widget/custom_shape/curved_edges/curved_edges.dart';

class TCurvedEdgesWidgets extends StatelessWidget {
  const TCurvedEdgesWidgets({
    super.key,
    this.child,
  });

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: TCustomCurvedEdges(),
      child: child,
    );
  }
}
