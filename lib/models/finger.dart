import 'package:flutter/material.dart';

class Finger {
  final Offset position;
  final Color color;

  Finger({required this.position, required this.color});

  static const List<Color> colors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.teal,
  ];
}
