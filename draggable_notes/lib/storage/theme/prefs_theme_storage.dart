import 'package:draggable_notes/storage/theme/theme_storage.dart';
import 'package:draggable_notes/utils/theme_utils.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Хранилище, которое сохраняет текущую темы в SharedPreferences
class PrefsThemeStorage implements ThemeStorage {
  final SharedPreferences _prefs;

  static const themeValueName = 'theme';

  PrefsThemeStorage(this._prefs);

  @override
  ThemeMode get themeMode {
    /// Изначальная тема в приложении будет системная
    final themeName = _prefs.getString(themeValueName) ?? ThemeMode.system.name;
    return themeName.toThemeMode();
  }

  @override
  Future<void> setThemeMode(ThemeMode theme) async {
    await _prefs.setString(themeValueName, theme.name);
  }
}
