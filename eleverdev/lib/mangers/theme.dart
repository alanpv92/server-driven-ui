import 'package:flutter/material.dart';

class ThemeManger {
  ThemeManger._();
  static ThemeManger instance = ThemeManger._();
  factory ThemeManger() => instance;

  ThemeData get getApplicationTheme => ThemeData(
    textTheme:const  TextTheme(
      headline5: TextStyle(fontWeight: FontWeight.w800, fontSize: 30),
    ),
  );
}
