import 'package:flutter/material.dart';

import 'leafPainter.dart';

class LeafWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: LeafPainter(),
      size: const Size(20, 20),
    );
  }
}
