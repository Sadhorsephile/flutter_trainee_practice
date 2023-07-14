import 'package:draggable_notes/data/note.dart';
import 'package:draggable_notes/interactor/notes_interactor.dart';
import 'package:elementary/elementary.dart';

/// Имплементация Elementary модели к экрану заметок
class NotesScreenModel extends ElementaryModel {
  final NotesInteractor _notesInteractor;

  NotesScreenModel(this._notesInteractor);

  /// Получить заметки
  List<NoteDomain> getNotes() => _notesInteractor.getNotes();

  /// Добавить заметку
  void addNote(NoteDomain note) => _notesInteractor.addNote(note);

  /// Поменять заметки местами
  void replaceNotes(int oldIndex, int newIndex) =>
      _notesInteractor.replaceNotes(oldIndex, newIndex);
}
