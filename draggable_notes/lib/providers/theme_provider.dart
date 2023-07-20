import 'package:draggable_notes/storage/theme/theme_storage.dart';
import 'package:flutter/material.dart';

/// Провайдер для темы
class ThemeProvider extends ChangeNotifier {
  /// Хранилище темы.
  final ThemeStorage _themeStorage;

  /// Текушая тема.
  late ThemeMode _currentTheme;

  ThemeMode get currentThemeMode => _currentTheme;

  ThemeProvider(this._themeStorage) {
    _currentTheme = _themeStorage.themeMode;
  }

  set currentThemeMode(ThemeMode value) {
    _currentTheme = value;
    _themeStorage.setThemeMode(_currentTheme);
    notifyListeners();
  }
}
