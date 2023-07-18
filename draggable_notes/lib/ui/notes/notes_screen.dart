import 'package:draggable_notes/res/colors.dart';
import 'package:draggable_notes/res/strings.dart';
import 'package:draggable_notes/ui/notes/notes_wm.dart';
import 'package:draggable_notes/ui/widgets/create_task_button.dart';
import 'package:draggable_notes/ui/widgets/note_card.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';

///
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
        child: ReorderableList(
          itemBuilder: (context, index) {
            return NoteCard(
              key: ValueKey(index),
              title: 'Заголовок',
              content: 'Описание заметки',
            );
          },
          itemCount: 7,
          onReorder: wm.handleDrag,
        ),
      ),
      floatingActionButton: CreateTaskButton(
        onTap: wm.onSaveTap,
      ),
    );
  }
}
