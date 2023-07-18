import 'package:draggable_notes/data/note.dart';

/// Хранилище для работы с заметками
/// Оно работает с заметками в формате [T]
abstract class NotesStorage<T> {
  /// Получить заметки
  List<T> getNotes();

  /// Добавить заметку
  void addNote(NoteDomain note);

  /// Поменять заметки местами
  void replaceNotes(int oldIndex, int newIndex);
}
