import 'package:draggable_notes/data/note.dart';
import 'package:draggable_notes/interactor/hive/adapters/note.dart';
import 'package:draggable_notes/interactor/hive/hive_storage.dart';
import 'package:draggable_notes/interactor/notes_interactor.dart';
import 'package:draggable_notes/interactor/notes_storage.dart';
import 'package:injectable/injectable.dart';

/// Реализация [NotesInteractor] для работы с заметками и их хранения в Hive
@Injectable(as: NotesInteractor)
class HiveNotesInteractor implements NotesInteractor {
  late final NotesStorage _hiveStorage;

  HiveNotesInteractor() {
    _hiveStorage = HiveStorage();
  }

  @override
  void addNote(NoteDomain note) => _hiveStorage.addNote(note);

  @override
  List<NoteDomain> getNotes() {
    final notesDb = _hiveStorage.getNotes();
    final notes = notesDb?.map((note) {
      note as NoteDB;
      return NoteDomain(
        title: note.title,
        content: note.content,
      );
    }).toList();

    return notes ?? [];
  }

  @override
  void replaceNotes(int oldIndex, int newIndex) =>
      _hiveStorage.replaceNotes(oldIndex, newIndex);
}
