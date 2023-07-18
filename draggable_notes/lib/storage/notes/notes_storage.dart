import 'package:draggable_notes/data/note.dart';

/// Хранилище для работы с заметками
/// Оно работает с заметками в формате [T]
abstract class NotesStorage<T extends NoteData> {
  /// Получить заметки
  List<T> getNotes();

  /// Добавить заметку
  void addNote(NoteDomain note);

  /// Поменять заметки местами
  void replaceNotes(int oldIndex, int newIndex);
}

/// Формат хранения заметки
/// Может быть в любой форме
/// Должен предоставлять геттеры для строк заголовка и контента
abstract class NoteData {
  String get title;
  String get content;
}
