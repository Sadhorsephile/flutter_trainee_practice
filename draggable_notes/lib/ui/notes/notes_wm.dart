import 'package:draggable_notes/ui/notes/notes_model.dart';
import 'package:draggable_notes/ui/notes/notes_screen.dart';
import 'package:draggable_notes/ui/widgets/create_note_dialog.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';

/// Абстракция Widget Model
abstract class INotesWidgetModel extends IWidgetModel {
  /// Сохранение заметки
  void onSaveTap();

  /// Обработка перетаскивания
  void handleDrag(int oldIndex, int newIndext);
}

NotesWidgetModel defaultAppWidgetModelFactory(BuildContext context) {
  return NotesWidgetModel(
    NotesScreenModel(),
  );
}

/// Имплементация и реализация Виджет модели [INotesWidgetModel]
class NotesWidgetModel extends WidgetModel<NotesScreen, NotesScreenModel>
    implements INotesWidgetModel {
  NotesWidgetModel(super._model);

  @override
  void handleDrag(int oldIndex, int newIndext) {
    // TODO(AndrewVorotyntsev):  implement handleDrag
  }

  @override
  void onSaveTap() {
    // TODO(AndrewVorotyntsev): обработать новую заметку
    showDialog(
      context: context,
      builder: (context) {
        return const CreateNoteDialog();
      },
    );
  }
}
