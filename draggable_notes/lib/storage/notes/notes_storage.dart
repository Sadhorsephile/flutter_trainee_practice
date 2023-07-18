import 'package:draggable_notes/data/note.dart';
import 'package:draggable_notes/storage/notes/note_data.dart';

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
