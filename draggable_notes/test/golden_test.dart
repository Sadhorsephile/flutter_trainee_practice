import 'package:draggable_notes/ui/notes/notes_screen.dart';
import 'package:draggable_notes/ui/widgets/create_note_dialog.dart';
import 'package:draggable_notes/ui/widgets/note_card.dart';
import 'package:flutter/material.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

void main() {
  testGoldens('Notes screen', (tester) async {
    final builder = DeviceBuilder()
      ..overrideDevicesForAllScenarios(
        devices: [
          Device.phone,
        ],
      )
      ..addScenario(
        widget: const NotesScreen(),
        name: 'notes_screen',
      );

    await tester.pumpDeviceBuilder(builder);

    await screenMatchesGolden(tester, 'notes_screen');
  });

  testGoldens('Notes card', (tester) async {
    final builder = GoldenBuilder.column()
      ..addScenario(
        'notes_card',
        const NoteCard(
          title: 'title',
          content: 'content',
        ),
      );

    await tester.pumpWidgetBuilder(builder.build(),
        surfaceSize: Size(400, 800));

    await screenMatchesGolden(tester, 'notes_card');
  });

  testGoldens('Create new note dialog', (tester) async {
    final builder = GoldenBuilder.column()
      ..addScenario(
        'create_new_note_dialog',
        CreateNoteDialog(
          titleEditingController: TextEditingController(),
          contentEditingController: TextEditingController(),
          onSaveTap: () {},
        ),
      );

    await tester.pumpWidgetBuilder(builder.build());

    await screenMatchesGolden(tester, 'create_new_note_dialog');
  });
}
