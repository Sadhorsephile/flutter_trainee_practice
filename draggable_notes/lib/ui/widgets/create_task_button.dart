import 'package:draggable_notes/res/colors.dart';
import 'package:draggable_notes/res/strings.dart';
import 'package:flutter/material.dart';

/// Кнопка для создания новой заметки
class CreateTaskButton extends StatelessWidget {
  /// Действие по нажатию
  final VoidCallback onTap;

  const CreateTaskButton({
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: AppColors.buttonColor,
      onPressed: onTap,
      tooltip: AppStrings.addNote,
      child: const Icon(Icons.note_add),
    );
  }
}
