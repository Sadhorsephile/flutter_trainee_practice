/// Базовый класс для логгеров
/// Для создани логгеров используется паттерн декоратор
abstract class AppLogger {
  /// Вложенный логгер для событий
  abstract final AppLogger? logger;

  void log(LogEventData data) => logger?.log(data);
}

/// Сущность события для логирования
class LogEventData {
  DateTime dateTime;
  String description;

  LogEventData({
    required this.dateTime,
    required this.description,
  });
}
