import 'package:draggable_notes/res/strings.dart';
import 'package:flutter/material.dart';

/// Диалог создания новой заметки
class CreateNoteDialog extends StatefulWidget {
  const CreateNoteDialog({
    super.key,
  });

  @override
  State<CreateNoteDialog> createState() => _CreateNoteDialogState();
}

class _CreateNoteDialogState extends State<CreateNoteDialog> {
  /// Контроллер для ввода названия заметки
  late final TextEditingController titleEditingController;

  /// Контроллер для ввода содержания заметки
  late final TextEditingController contentEditingController;

  @override
  void initState() {
    titleEditingController = TextEditingController();
    contentEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    titleEditingController.dispose();
    contentEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      alignment: Alignment.topCenter,
      title: const Text(AppStrings.newNote),
      content: SizedBox(
        height: 273,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(AppStrings.title),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: titleEditingController,
              decoration: const InputDecoration(
                hintText: AppStrings.enterTitle,
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(AppStrings.content),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: contentEditingController,
              decoration: const InputDecoration(
                hintText: AppStrings.enterContent,
                border: OutlineInputBorder(),
              ),
              maxLines: 4,
            ),
          ],
        ),
      ),
      actionsAlignment: MainAxisAlignment.spaceAround,
      actionsPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      actions: [
        TextButton(
          child: const Text(AppStrings.save),
          onPressed: () {
            // TODO(AndrewVorotyntsev):  вернуть заметку
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text(AppStrings.cancel),
          onPressed: Navigator.of(context).pop,
        ),
      ],
    );
  }
}
