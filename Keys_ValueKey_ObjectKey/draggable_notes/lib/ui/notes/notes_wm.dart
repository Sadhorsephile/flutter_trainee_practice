import 'package:draggable_notes/data/note.dart';
import 'package:draggable_notes/di/di_container.dart';
import 'package:draggable_notes/interactor/notes/notes_interactor.dart';
import 'package:draggable_notes/providers/theme_provider.dart';
import 'package:draggable_notes/ui/notes/notes_model.dart';
import 'package:draggable_notes/ui/notes/notes_screen.dart';
import 'package:draggable_notes/ui/widgets/create_note_dialog.dart';
import 'package:draggable_notes/ui/widgets/snack_bars.dart';
import 'package:draggable_notes/ui/widgets/theme_picker_dialog.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Абстракция Widget Model для экрана заметок
abstract class INotesWidgetModel extends IWidgetModel {
  /// Состояние списка заметок
  ListenableState<EntityState<List<NoteDomain>>> get notesListState;

  /// Добавление заметки
  void onCreateNoteTap();

  /// Обработка перетаскивания со старого места [oldIndex] на новое [newIndex]
  void handleDrag(int oldIndex, int newIndex);

  /// Нажатие на выбор темы
  void onThemeChangeTap();

  /// Обновить список заметок
  void updateNotes();
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

  @override
  final EntityStateNotifier<List<NoteDomain>> notesListState =
      EntityStateNotifier<List<NoteDomain>>();

  @override
  void initWidgetModel() {
    updateNotes();
    super.initWidgetModel();
  }

  /// Обновить список заметок
  @override
  void updateNotes() {
    try {
      final notes = model.getNotes();
      notesListState.content(notes);
    } on Exception catch (e) {
      /// Если данные не было - показываем экран с ошибкой
      if (notesListState.value?.data?.isEmpty ?? true) {
        notesListState.error(e);
      } else {
        /// Если данные уже были загружены - показать снэкбар
        ScaffoldMessenger.of(context).showSnackBar(
          ErrorSnackBar(
            onActionTap: updateNotes,
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    notesListState.dispose();
    super.dispose();
  }

  @override
  void handleDrag(int oldIndex, int newIndex) {
    model.replaceNotes(oldIndex, newIndex);
    updateNotes();
  }

  @override
  Future<void> onCreateNoteTap() async {
    final createdNote = await showDialog<NoteDomain?>(
      context: context,
      builder: (context) => const CreateNoteDialog(),
    );
    if (createdNote != null) {
      model.addNote(createdNote);
      updateNotes();
    }
  }

  @override
  void onThemeChangeTap() {
    showDialog(
      context: context,
      builder: (context) {
        return ThemePickerDialog(
          onThemeChanged: changeTheme,
        );
      },
    );
  }

  void changeTheme(ThemeMode? theme) {
    if (theme != null) {
      Provider.of<ThemeProvider>(context, listen: false).currentThemeMode =
          theme;
    }
  }
}
