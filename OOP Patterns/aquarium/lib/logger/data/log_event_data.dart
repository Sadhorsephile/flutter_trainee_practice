/// Сущность события для логирования
class LogEventData {
  /// Вреся наступления события
  DateTime dateTime;

  /// Описание события
  String description;

  /// Объект события
  Object? object;

  LogEventData({
    required this.dateTime,
    required this.description,
    this.object,
  });
}
