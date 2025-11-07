import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DarklightModeProvider with ChangeNotifier {
  bool _isDark = false;

  bool get isDark => _isDark;

  void setTheme() {
    _isDark = !isDark;
    notifyListeners();
  }

  ThemeMode get currentTheme => _isDark ? ThemeMode.dark : ThemeMode.light;
}
