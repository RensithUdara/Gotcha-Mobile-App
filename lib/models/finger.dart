import 'package:flutter/material.dart';

class Finger {
  final Offset position;
  final Color color;
  final int id;

  Finger({
    required this.position, 
    required this.color,
    required this.id,
  });

  static const List<Color> colors = [
    Color(0xFF6366F1), // Indigo
    Color(0xFFEC4899), // Pink
    Color(0xFF10B981), // Emerald
    Color(0xFFF59E0B), // Amber
    Color(0xFF8B5CF6), // Violet
    Color(0xFF06B6D4), // Cyan
    Color(0xFFEF4444), // Red
    Color(0xFF84CC16), // Lime
    Color(0xFFF97316), // Orange
    Color(0xFF14B8A6), // Teal
  ];
}
