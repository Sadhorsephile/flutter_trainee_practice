import 'package:draggable_notes/data/note.dart';
import 'package:draggable_notes/interactor/hive/hive_repository.dart';
import 'package:draggable_notes/interactor/notes_interactor.dart';
import 'package:injectable/injectable.dart';

/// Реализация для [NotesInteractor] для работы с заметками и их хранения в Hive
@Injectable(as: NotesInteractor)
class HiveNotesInteractor implements NotesInteractor {
  late final HiveRepository _hiveRepository;

  HiveNotesInteractor() {
    _hiveRepository = HiveRepository();
  }

  @override
  void addNote(NoteDomain note) => _hiveRepository.addNote(note);

  @override
  List<NoteDomain> getNotes() => _hiveRepository.getNotes();

  @override
  void replaceNotes(int oldIndex, int newIndex) =>
      _hiveRepository.replaceNotes(oldIndex, newIndex);
}
