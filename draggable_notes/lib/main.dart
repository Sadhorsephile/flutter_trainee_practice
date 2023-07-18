import 'package:draggable_notes/di/di_container.dart';
import 'package:draggable_notes/interactor/notes/hive/hive_storage.dart';
import 'package:draggable_notes/res/themes.dart';
import 'package:draggable_notes/storage/notes/hive/adapters/note.dart';
import 'package:draggable_notes/storage/theme/prefs_theme_storage.dart';
import 'package:draggable_notes/ui/notes/notes_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  /// Инициализируем локальную базу данных
  await Hive.initFlutter();
  Hive.registerAdapter<NoteDB>(NoteDBAdapter());
  await Hive.openBox<dynamic>(notesBoxName);

  final prefs = await SharedPreferences.getInstance();
  final themeStorage = PrefsThemeStorage(prefs);

  configureDependencies();

  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(themeStorage),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      themeMode: context.watch<ThemeProvider>().currentThemeMode,
      themeAnimationDuration: const Duration(milliseconds: 500),
      home: const NotesScreen(),
    );
  }
}
