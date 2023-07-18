import 'package:draggable_notes/data/note.dart';

/// Хранилище для работы с заметками
abstract class NotesStorage {
  /// Получить заметки
  List<dynamic>? getNotes();

  /// Добавить заметку
  void addNote(NoteDomain note);

  /// Поменять заметки местами
  void replaceNotes(int oldIndex, int newIndex);
}
