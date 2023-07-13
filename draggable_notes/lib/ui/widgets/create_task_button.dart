import 'package:draggable_notes/res/strings.dart';
import 'package:flutter/material.dart';

/// Кнопка для создания новой заметки
class CreateTaskButton extends StatelessWidget {
  /// Действие по нажатию
  final VoidCallback onTap;

  const CreateTaskButton({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.orange,
      onPressed: onTap,
      tooltip: AppStrings.addNote,
      child: const Icon(Icons.note_add),
    );
  }
}
