import 'package:draggable_notes/res/colors.dart';
import 'package:flutter/material.dart';

class AppThemes {
  static ThemeData lightTheme = ThemeData(
    canvasColor: AppColorsLight.canvasColor,
    primaryColor: AppColorsLight.mainColor,
    cardColor: AppColorsLight.cardColor,
    dialogBackgroundColor: Colors.white,
  );
  static ThemeData darkTheme = ThemeData(
    canvasColor: Colors.black,
    cardColor: Colors.grey,
    primaryColor: Colors.yellow,
  );
}

class ThemeProvider extends ChangeNotifier {
  ThemeMode _currentTheme = ThemeMode.light;

  ThemeMode get currentThemeMode => _currentTheme;

  set currentThemeMode(ThemeMode value) {
    _currentTheme = value;
    notifyListeners();
  }
}
