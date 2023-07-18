/// Формат хранения заметки
/// Может быть в любой форме
/// Должен предоставлять геттеры для строк заголовка и контента
abstract class NoteData {
  /// Заголовок заметки
  String get title;

  /// Содержание заметки
  String get content;
}