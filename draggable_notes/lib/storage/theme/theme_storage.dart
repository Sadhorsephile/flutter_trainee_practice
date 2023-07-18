import 'package:flutter/material.dart';

/// Хранилище темы в приложении
abstract class ThemeStorage {
  /// Получить сохраненную тему
  ThemeMode getThemeMode();

  /// Сохранить тему
  void setThemeMode(ThemeMode theme);
}
