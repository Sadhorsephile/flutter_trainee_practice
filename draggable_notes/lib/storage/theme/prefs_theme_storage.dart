import 'package:draggable_notes/storage/theme/theme_storage.dart';
import 'package:draggable_notes/utils/theme_utils.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefsThemeStorage implements ThemeStorage {
  final SharedPreferences _prefs;

  PrefsThemeStorage(this._prefs);

  @override
  ThemeMode getThemeMode() {
    final themeName = _prefs.getString('theme') ?? 'system';
    return themeName.toThemeMode();
  }

  @override
  Future<void> setThemeMode(ThemeMode theme) async {
    await _prefs.setString('theme', theme.name);
  }
}
