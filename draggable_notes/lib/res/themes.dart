import 'package:draggable_notes/res/colors.dart';
import 'package:flutter/material.dart';

class AppThemes {
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColorsLight.canvasColor,
    primaryColor: AppColorsLight.mainColor,
    cardColor: AppColorsLight.cardColor,
    dialogBackgroundColor: AppColorsLight.canvasColor,
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColorsLight.buttonColor,
    ),
    radioTheme: RadioThemeData(
      fillColor: MaterialStateColor.resolveWith((states) =>
          states.contains(MaterialState.selected)
              ? AppColorsLight.radioColorSelected
              : AppColorsLight.radioColorUnselected),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: AppColorsDark.canvasColor,
    primaryColor: AppColorsDark.mainColor,
    cardColor: AppColorsDark.cardColor,
    dialogBackgroundColor: AppColorsDark.dialogColor,
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColorsDark.buttonColor,
    ),
    radioTheme: RadioThemeData(
      fillColor: MaterialStateColor.resolveWith((states) =>
          states.contains(MaterialState.selected)
              ? AppColorsDark.radioColorSelected
              : AppColorsDark.radioColorUnselected),
    ),
  );
}

class ThemeProvider extends ChangeNotifier {
  // TODO: брать с сохраненной
  ThemeMode _currentTheme = ThemeMode.light;

  ThemeMode get currentThemeMode => _currentTheme;

  set currentThemeMode(ThemeMode value) {
    _currentTheme = value;
    notifyListeners();
  }
}
