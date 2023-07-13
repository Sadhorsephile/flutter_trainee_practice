import 'package:draggable_notes/data/note.dart';

/// Интерактор для работы с заметками
abstract class NotesInteractor {
  /// Получить заметки
  List<NoteDomain> getNotes();

  /// Добавить заметку
  void addNote(NoteDomain note);

  /// Поменять заметки местами
  void replaceNotes(int oldIndex, int newIndex);
}
