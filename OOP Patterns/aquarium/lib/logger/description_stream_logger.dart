import 'dart:async';

import 'package:aquarium/logger/base_logger.dart';
import 'package:intl/intl.dart';

/// Логгер который заносит описание событий в стрим
class DescriptionStreamLogger extends AppLogger {
  /// Вложенный логгер для событий
  @override
  final AppLogger? logger;

  /// Стрим для записи событий
  StreamController<String> logStream;

  /// Формат для строки данных
  static DateFormat formatter = DateFormat('dd.MM.yyyy hh:mm:ss');

  DescriptionStreamLogger({
    required this.logStream,
    this.logger,
  });

  @override
  void log(LogEventData data) {
    logStream.add('${formatter.format(data.dateTime)} : ${data.description}');
    super.log(data);
  }
}
