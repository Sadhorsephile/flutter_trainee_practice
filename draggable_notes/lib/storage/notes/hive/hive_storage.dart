import 'package:draggable_notes/data/note.dart';
import 'package:draggable_notes/storage/notes/hive/adapters/note.dart';
import 'package:draggable_notes/storage/notes/notes_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';

const notesBoxName = 'notesBox';
const notesDBKey = 'notes';

/// Хранилище заметок в Hive
class HiveStorage implements NotesStorage {
  /// Согласно документации нельзя указать в generic тип List
  /// Вынужденное решение - приводить типы вручную (as)
  /// ref: https://docs.hivedb.dev/#/basics/boxes (последний пункт)
  Box<dynamic> get _notesBox => Hive.box<dynamic>(notesBoxName);

  @override
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

  @override
  List<dynamic>? getNotes() {
    return _notesBox.get(notesDBKey) as List<dynamic>?;
  }

  @override
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
