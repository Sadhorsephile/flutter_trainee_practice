import 'package:draggable_notes/providers/theme_provider.dart';
import 'package:draggable_notes/res/themes.dart';
import 'package:draggable_notes/ui/notes/notes_screen.dart';
import 'package:draggable_notes/ui/widgets/create_note_dialog.dart';
import 'package:draggable_notes/ui/widgets/note_card.dart';
import 'package:draggable_notes/ui/widgets/theme_picker_dialog.dart';
import 'package:flutter/material.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';

import 'mock/mock_notes_interactor.dart';

void main() {
  testGoldens('Notes screen (Light theme)', (tester) async {
    final builder = DeviceBuilder()
      ..overrideDevicesForAllScenarios(
        devices: [
          Device.phone,
        ],
      )
      ..addScenario(
        widget: Theme(
          data: AppThemes.lightTheme,
          child: const NotesScreen(),
        ),
        name: 'notes_screen_light',
      );

    await tester.pumpDeviceBuilder(builder);

    await screenMatchesGolden(tester, 'notes_screen_light');
  });

  testGoldens('Notes card (Light theme)', (tester) async {
    final builder = GoldenBuilder.column()
      ..addScenario(
        'notes_card_light',
        Theme(
          data: AppThemes.lightTheme,
          child: const NoteCard(
            title: 'title',
            content: 'content',
          ),
        ),
      );

    await tester.pumpWidgetBuilder(
      builder.build(),
      surfaceSize: const Size(400, 800),
    );

    await screenMatchesGolden(tester, 'notes_card_light');
  });

  testGoldens('Create new note dialog (Light theme)', (tester) async {
    final builder = GoldenBuilder.column()
      ..addScenario(
        'create_new_note_dialog_light',
        Theme(
          data: AppThemes.lightTheme,
          child: const CreateNoteDialog(),
        ),
      );

    await tester.pumpWidgetBuilder(builder.build());

    await screenMatchesGolden(tester, 'create_new_note_dialog_light');
  });

  testGoldens('Theme picker dialog (Light theme)', (tester) async {
    // Явно указывать тип после final иначе тест не проходит
    final ThemeProvider themeProver = ThemeProviderMock();

    when(
      () => themeProver.currentThemeMode,
    ).thenAnswer(
      (_) => ThemeMode.light,
    );
    final builder = GoldenBuilder.column()
      ..addScenario(
        'theme_picker_dialog_light',
        ChangeNotifierProvider(
          create: (_) => themeProver,
          child: Theme(
            data: AppThemes.lightTheme,
            child: Builder(builder: (context) {
              return ThemePickerDialog(
                onThemeChanged: (_) {},
              );
            }),
          ),
        ),
      );

    await tester.pumpWidgetBuilder(builder.build());

    await screenMatchesGolden(tester, 'theme_picker_dialog_light');
  });

  testGoldens('Notes screen (Dark Mode)', (tester) async {
    final builder = DeviceBuilder()
      ..overrideDevicesForAllScenarios(
        devices: [
          Device.phone,
        ],
      )
      ..addScenario(
        widget: Theme(
          data: AppThemes.darkTheme,
          child: const NotesScreen(),
        ),
        name: 'notes_screen_dark',
      );

    await tester.pumpDeviceBuilder(builder);

    await screenMatchesGolden(tester, 'notes_screen');
  });

  testGoldens('Notes card (Dark theme)', (tester) async {
    final builder = GoldenBuilder.column()
      ..addScenario(
        'notes_card_dark',
        Theme(
          data: AppThemes.darkTheme,
          child: const NoteCard(
            title: 'title',
            content: 'content',
          ),
        ),
      );

    await tester.pumpWidgetBuilder(
      builder.build(),
      surfaceSize: const Size(400, 800),
    );

    await screenMatchesGolden(tester, 'notes_card_dark');
  });

  testGoldens('Create new note dialog (Dark theme)', (tester) async {
    final builder = GoldenBuilder.column()
      ..addScenario(
        'create_new_note_dialog_dark',
        Theme(
          data: AppThemes.darkTheme,
          child: const CreateNoteDialog(),
        ),
      );

    await tester.pumpWidgetBuilder(builder.build());

    await screenMatchesGolden(tester, 'create_new_note_dialog_dark');
  });

  testGoldens('Theme picker dialog (Dark theme)', (tester) async {
    // Явно указывать тип после final иначе тест не проходит
    final ThemeProvider themeProver = ThemeProviderMock();
    when(
      () => themeProver.currentThemeMode,
    ).thenAnswer(
      (_) => ThemeMode.dark,
    );
    final builder = GoldenBuilder.column()
      ..addScenario(
        'theme_picker_dialog_dark',
        ChangeNotifierProvider(
          create: (_) => themeProver,
          child: Theme(
            data: AppThemes.darkTheme,
            child: Builder(builder: (context) {
              return ThemePickerDialog(
                onThemeChanged: (_) {},
              );
            }),
          ),
        ),
      );

    await tester.pumpWidgetBuilder(builder.build());

    await screenMatchesGolden(tester, 'theme_picker_dialog_dark');
  });
}
