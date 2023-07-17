import 'package:draggable_notes/data/note.dart';
import 'package:draggable_notes/interactor/hive/adapters/note.dart';
import 'package:draggable_notes/interactor/hive/hive_storage.dart';
import 'package:draggable_notes/interactor/notes_interactor.dart';
import 'package:injectable/injectable.dart';

/// Реализация для [NotesInteractor] для работы с заметками и их хранения в Hive
@Injectable(as: NotesInteractor)
class HiveNotesInteractor implements NotesInteractor {
  late final HiveStorage _hiveRepository;

  HiveNotesInteractor() {
    _hiveRepository = HiveStorage();
  }

  @override
  void addNote(NoteDomain note) => _hiveRepository.addNote(note);

  @override
  List<NoteDomain> getNotes() {
    final notesDb = _hiveRepository.getNotes();
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
      _hiveRepository.replaceNotes(oldIndex, newIndex);
}
