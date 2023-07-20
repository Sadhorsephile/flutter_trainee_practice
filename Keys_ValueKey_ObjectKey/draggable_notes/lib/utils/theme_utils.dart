import 'package:flutter/material.dart';

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
