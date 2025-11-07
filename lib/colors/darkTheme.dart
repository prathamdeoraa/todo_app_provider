import 'package:flutter/material.dart';

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: Colors.teal.shade800,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.black,
    elevation: 0,
    foregroundColor: Colors.white,
  ),
  textTheme: const TextTheme(bodyMedium: TextStyle(color: Colors.white)),
  // cardColor: Colors.grey
);
