import 'package:draggable_notes/data/note.dart';
import 'package:draggable_notes/interactor/hive/adapters/note.dart';
import 'package:hive_flutter/hive_flutter.dart';

const notesBoxName = 'notesBox';
const notesDBKey = 'notes';

/// Репозиторий для работы с Hive
class HiveRepository {
  /// Согласно документации нельзя указать в generic типе List
  /// Вынужденное решение - приводить типы вручную (as)
  Box<dynamic> get _notesBox => Hive.box<dynamic>(notesBoxName);

  void addNote(NoteDomain note) {
    var notes = _notesBox.get(notesDBKey) as List<dynamic>?;
    notes ??= [];
    notes.add(
      NoteDB(
        title: note.title,
        content: note.content,
      ),
    );
    _notesBox.put(notesDBKey, notes);
  }

  List<dynamic>? getNotes() {
    return _notesBox.get(notesDBKey) as List<dynamic>?;
  }

  void replaceNotes(int oldIndex, int newIndex) {
    final notesDb = _notesBox.get(notesDBKey) as List<dynamic>?;
    final item = notesDb?.removeAt(oldIndex);
    if (item != null) {
      if (oldIndex < newIndex) {
        notesDb?.insert(newIndex - 1, item);
      } else {
        notesDb?.insert(newIndex, item);
      }
      _notesBox.put(notesDBKey, notesDb);
    }
  }
}
