import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: Colors.teal.shade100,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.teal,
    elevation: 0,
    foregroundColor: Colors.black, // title & icons color
  ),
  textTheme: const TextTheme(bodyMedium: TextStyle(color: Colors.black87)),
);
