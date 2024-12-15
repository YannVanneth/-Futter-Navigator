import 'package:flutter/material.dart';

class Products {
  late String boxColor;
  late double size;
  late Color color;
  late int quantity;
  Products({
    required this.boxColor,
    required this.size,
    required this.color,
    required this.quantity,
  });

  Products.add(Map<String, dynamic> map) {
    boxColor = getColorName(map["Color"]);
    size = map["Size"] ?? "";
    color = map["Color"] ?? "";
    quantity = 1;
  }

  void setQty(int quantity) => this.quantity += quantity;

  String getColorName(Color color) {
    switch (color) {
      case Colors.blue:
        return "Blue";
      case Colors.green:
        return "Green";
      case Colors.red:
        return "Red";
      default:
        return "Unknown";
    }
  }
}
