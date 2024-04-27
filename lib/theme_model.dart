import 'package:flutter/material.dart';

class ThemeModel extends ChangeNotifier {
  ThemeData _themeData;

  ThemeModel() : _themeData = ThemeData.light();

  ThemeData get theme => _themeData;

  void toggleTheme() {
    if (_themeData == ThemeData.light()) {
      _themeData = ThemeData.dark();
    } else {
      _themeData = ThemeData.light();
    }
    notifyListeners(); 
  }
}
