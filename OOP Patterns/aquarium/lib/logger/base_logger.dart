/// Базовый класс для логгеров
/// Для создани логгеров используется паттерн декоратор
abstract class AppLogger {
  /// Вложенный логгер для событий
  abstract final AppLogger? logger;

  void log(LogEventData data) => logger?.log(data);
}

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
