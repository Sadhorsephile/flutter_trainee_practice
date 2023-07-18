import 'package:draggable_notes/storage/notes/note_data.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'note.g.dart';

/// Описание сущности заметки, которая будет храниться в Hive
@HiveType(typeId: 0)
class NoteDB extends HiveObject implements NoteData {
  @override
  @HiveField(0)
  final String title;

  @override
  @HiveField(1)
  final String content;

  NoteDB({
    required this.title,
    required this.content,
  });
}
