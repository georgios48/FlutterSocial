import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    surface: Color.fromARGB(255, 201, 200, 199),
    primary: Color(0xFF837d7d),
    secondary: Color(0xFFd6d0b8),
    tertiary: Color(0xFFf1f4c6),
  ),
  scaffoldBackgroundColor: const Color.fromARGB(255, 201, 200, 199),
);
