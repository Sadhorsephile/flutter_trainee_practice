import 'package:draggable_notes/res/colors.dart';
import 'package:draggable_notes/storage/theme/theme_storage.dart';
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
    appBarTheme: const AppBarTheme(
      color: AppColorsLight.mainColor,
    ),
    radioTheme: RadioThemeData(
      fillColor: MaterialStateColor.resolveWith(
        (states) => states.contains(MaterialState.selected)
            ? AppColorsLight.radioColorSelected
            : AppColorsLight.radioColorUnselected,
      ),
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
    appBarTheme: const AppBarTheme(
      color: AppColorsDark.mainColor,
    ),
    radioTheme: RadioThemeData(
      fillColor: MaterialStateColor.resolveWith((states) =>
          states.contains(MaterialState.selected)
              ? AppColorsDark.radioColorSelected
              : AppColorsDark.radioColorUnselected),
    ),
    textTheme: TextTheme(
      bodyMedium: TextStyle(color: AppColorsDark.textColor),
    ),
  );
}

/// Провайдер для темы
class ThemeProvider extends ChangeNotifier {
  /// Хранилище темы.
  final ThemeStorage _themeStorage;

  /// Текушая тема.
  late ThemeMode _currentTheme;

  ThemeMode get currentThemeMode => _currentTheme;

  ThemeProvider(this._themeStorage) {
    _currentTheme = _themeStorage.getThemeMode();
  }

  set currentThemeMode(ThemeMode value) {
    _currentTheme = value;
    _themeStorage.setThemeMode(_currentTheme);
    notifyListeners();
  }
}

extension StringTheme on String {
  /// Получить режим темы по строке
  ThemeMode toThemeMode() {
    if (this == 'light') {
      return ThemeMode.light;
    }
    if (this == 'dark') {
      return ThemeMode.dark;
    }
    return ThemeMode.system;
  }
}
