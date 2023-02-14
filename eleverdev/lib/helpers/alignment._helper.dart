import 'package:flutter/material.dart';

class AlignmentHelper {
  static Alignment? getAlignMent({required String? alignment}) {
    switch (alignment) {
      case null:
        return null;
      case "Alignment.bottomCenter":
        return Alignment.bottomCenter;
      case "Alignment.bottomLeft":
        return Alignment.bottomLeft;
      case "Alignment.bottomRight":
        return Alignment.bottomRight;
      case "Alignment.center":
        return Alignment.center;
      case "Alignment.centerLeft":
        return Alignment.centerLeft;
      case "Alignment.centerRight":
        return Alignment.centerRight;
      case "Alignment.topCenter":
        return Alignment.topCenter;
      case "Alignment.topLeft":
        return Alignment.topLeft;
      case "Alignment.topRight":
        return Alignment.topRight;
      default:
        return null;
    }
  }
}
