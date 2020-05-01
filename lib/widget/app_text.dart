import 'package:flutter/material.dart';

Text text(
  String str, {
  double fontSize = 16,
  Color color = Colors.black,
  bool bold = false,
}) {
  return Text(
    str ?? "",
    style: TextStyle(
      fontSize: fontSize,
      color: color,
      fontWeight: bold ? FontWeight.bold : FontWeight.normal,
    ),
  );
}
