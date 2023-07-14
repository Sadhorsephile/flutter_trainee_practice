import 'package:hive/hive.dart';
part 'note.g.dart';

/// Описание сущности заметки, которая будет храниться в Hive
@HiveType(typeId: 0)
class NoteDB extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  String content;

  NoteDB({
    required this.title,
    required this.content,
  });
}
