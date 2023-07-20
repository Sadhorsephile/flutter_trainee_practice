import 'package:flutter/material.dart';

/// Хранилище темы в приложении
abstract interface class ThemeStorage {
  /// Получить сохраненную тему
  ThemeMode get themeMode;

  /// Сохранить тему
  void setThemeMode(ThemeMode theme);
}
