import 'package:draggable_notes/res/colors.dart';
import 'package:flutter/material.dart';

/// Темы приложения
class AppThemes {
  /// Светлая тема приложения
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
    snackBarTheme: SnackBarThemeData(
      backgroundColor: AppColorsLight.errorColor,
    ),
  );

  /// Темная тема приложения
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
    snackBarTheme: const SnackBarThemeData(
      backgroundColor: AppColorsDark.errorColor,
    ),
  );
}
