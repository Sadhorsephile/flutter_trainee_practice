import 'package:draggable_notes/data/note.dart';
import 'package:draggable_notes/res/colors.dart';
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
        backgroundColor: AppColors.mainColor,
        title: const Text(AppStrings.notes),
      ),
      body: Center(
        child: EntityStateNotifierBuilder<List<NoteDomain>>(
          listenableEntityState: wm.notesListState,
          errorBuilder: (_, __, ___) => _ErrorWidget(onRefresh: wm.updateNotes),
          builder: (context, notesList) {
            if (notesList == null) {
              return const NotesPlaceholder();
            }
            if (notesList.isEmpty) {
              return const NotesPlaceholder();
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

/// Экран ошибки с возможностью рефреша.
class _ErrorWidget extends StatelessWidget {
  final VoidCallback onRefresh;
  const _ErrorWidget({
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(AppStrings.loadingError),
          IconButton(
            icon: const Icon(
              Icons.refresh,
              size: 30,
            ),
            iconSize: 30,
            onPressed: onRefresh,
          ),
        ],
      ),
    );
  }
}

/// Виджет, который отображается когда заметок нет
class NotesPlaceholder extends StatelessWidget {
  const NotesPlaceholder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(AppStrings.emptyNotes),
    );
  }
}
