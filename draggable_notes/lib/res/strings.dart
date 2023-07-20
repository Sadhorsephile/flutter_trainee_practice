import 'package:flutter/material.dart';

class AppStrings {
  static const notes = 'Заметки';
  static const addNote = 'Добавить заметку';
  static const newNote = 'Новая заметка';
  static const title = 'Название';
  static const enterTitle = 'Введите навание';
  static const content = 'Содержание';
  static const enterContent = 'Введите содержание';
  static const save = 'Сохранить';
  static const cancel = 'Отмена';
  static const emptyNotes = 'Здесь ничего нет';
  static const loadingError = 'Произошла ошибка во время загрузки данных.';
  static const refresh = 'Обновить';
  static const chooseThemeMode = 'Выберите тему';
  static const lightThemeMode = 'Светлая';
  static const darkThemeMode = 'Темная';
  static const systemThemeMode = 'Системная';

  static String themeMode(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return lightThemeMode;
      case ThemeMode.dark:
        return darkThemeMode;
      case ThemeMode.system:
        return systemThemeMode;
    }
  }
}
