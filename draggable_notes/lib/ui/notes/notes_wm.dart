import 'package:draggable_notes/data/note.dart';
import 'package:draggable_notes/di/di_container.dart';
import 'package:draggable_notes/interactor/notes_interactor.dart';
import 'package:draggable_notes/ui/notes/notes_model.dart';
import 'package:draggable_notes/ui/notes/notes_screen.dart';
import 'package:draggable_notes/ui/widgets/create_note_dialog.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';

/// Абстракция Widget Model для экрана заметок
abstract class INotesWidgetModel extends IWidgetModel {
  ListenableState<EntityState<List<NoteDomain>>> get notesListState;

  /// Добавление заметки
  void onCreateNoteTap();

  /// Обработка перетаскивания со старого места [oldIndex] на новое [newIndex]
  void handleDrag(int oldIndex, int newIndex);
}

NotesWidgetModel defaultAppWidgetModelFactory(BuildContext context) {
  return NotesWidgetModel(
    NotesScreenModel(
      getIt.get<NotesInteractor>(),
    ),
  );
}

/// Имплементация и реализация Виджет модели [INotesWidgetModel]
class NotesWidgetModel extends WidgetModel<NotesScreen, NotesScreenModel>
    implements INotesWidgetModel {
  NotesWidgetModel(super._model);

  late final TextEditingController titleEditingController;
  late final TextEditingController contentEditingController;

  @override
  EntityStateNotifier<List<NoteDomain>> notesListState =
      EntityStateNotifier<List<NoteDomain>>();

  @override
  void initWidgetModel() {
    titleEditingController = TextEditingController();
    contentEditingController = TextEditingController();
    getPhoto();
    super.initWidgetModel();
  }

  void getPhoto() {
    final notes = model.getNotes();
    notesListState.content(notes);
  }

  @override
  void dispose() {
    titleEditingController.dispose();
    contentEditingController.dispose();
    notesListState.dispose();
    super.dispose();
  }

  @override
  void handleDrag(int oldIndex, int newIndex) {
    model.replaceNotes(oldIndex, newIndex);
    getPhoto();
  }

  @override
  void onCreateNoteTap() {
    showDialog(
      context: context,
      builder: (context) {
        return CreateNoteDialog(
          titleEditingController: titleEditingController,
          contentEditingController: contentEditingController,
          onSaveTap: _saveNote,
        );
      },
    );
  }

  void _saveNote() {
    model.addNote(NoteDomain(
      title: titleEditingController.text,
      content: contentEditingController.text,
    ));
    titleEditingController.text = '';
    contentEditingController.text = '';
    getPhoto();
  }
}
