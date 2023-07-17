import 'package:draggable_notes/di/di_container.dart';
import 'package:draggable_notes/interactor/hive/adapters/note.dart';
import 'package:draggable_notes/interactor/hive/hive_storage.dart';
import 'package:draggable_notes/ui/notes/notes_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  /// Инициализируем локальную базу данных
  await Hive.initFlutter();
  Hive.registerAdapter<NoteDB>(NoteDBAdapter());
  await Hive.openBox<dynamic>(notesBoxName);

  configureDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: NotesScreen(),
    );
  }
}
