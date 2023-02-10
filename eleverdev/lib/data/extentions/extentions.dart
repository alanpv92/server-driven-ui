import 'package:flutter/material.dart';

extension HexColor on Color {
  static Color? fromHex(String hexColorString) {
    hexColorString = hexColorString.replaceAll("#", '');
    if (hexColorString.length == 6) {
      hexColorString = "FF$hexColorString";
    }
    final int? colorCode = int.tryParse(hexColorString, radix: 16);
    if (colorCode == null) {
      return null;
    }
    return Color(colorCode);
  }
}