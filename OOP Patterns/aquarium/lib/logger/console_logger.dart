import 'package:aquarium/logger/base_logger.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class ConsoleLogger extends AppLogger {
  /// Вложенный логгер для событий
  @override
  final AppLogger? logger;

  /// Формат для строки данных
  static DateFormat formatter = DateFormat('dd.MM.yyyy hh:mm:ss');

  ConsoleLogger({
    this.logger,
  });

  @override
  void log(LogEventData data) {
    if (kDebugMode) {
      print(
          '${formatter.format(data.dateTime)} : ${data.description}\n ${data.object}');
    }
    super.log(data);
  }
}
