import 'package:aquarium/logger/data/log_event_data.dart';

/// Базовый класс для логгеров
/// Для создани логгеров используется паттерн декоратор
abstract class AppLogger {
  /// Вложенный логгер для событий
  abstract final AppLogger? logger;

  void log(LogEventData data) => logger?.log(data);
}
