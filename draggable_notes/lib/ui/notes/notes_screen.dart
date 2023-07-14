import 'package:draggable_notes/data/note.dart';
import 'package:draggable_notes/res/strings.dart';
import 'package:draggable_notes/ui/notes/notes_wm.dart';
import 'package:draggable_notes/ui/widgets/create_task_button.dart';
import 'package:draggable_notes/ui/widgets/note_card.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';

/// Экран заметок
class NotesScreen extends ElementaryWidget<INotesWidgetModel> {
  const NotesScreen({
    Key? key,
    WidgetModelFactory wmFactory = defaultAppWidgetModelFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(INotesWidgetModel wm) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: const Text(AppStrings.notes),
      ),
      body: Center(
        child: EntityStateNotifierBuilder<List<NoteDomain>>(
          listenableEntityState: wm.notesListState,
          builder: (context, notesList) {
            if (notesList == null) {
              return const Center(
                child: Text(AppStrings.emptyNotes),
              );
            }
            return ReorderableListView.builder(
              itemCount: notesList.length,
              itemBuilder: (context, index) {
                final note = notesList[index];
                return NoteCard(
                  key: ObjectKey(note),
                  title: note.title,
                  content: note.content,
                );
              },
              onReorder: wm.handleDrag,
            );
          },
        ),
      ),
      floatingActionButton: CreateTaskButton(
        onTap: wm.onCreateNoteTap,
      ),
    );
  }
}
