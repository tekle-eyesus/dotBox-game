import 'package:flutter/material.dart';

Widget _buildDot() {
  return Container(
    width: 16,
    height: 16,
    decoration: BoxDecoration(
      color: Colors.deepPurple.shade900,
      shape: BoxShape.circle,
    ),
  );
}

get buildDot => _buildDot;
