import 'dart:async';

import 'package:aquarium/logger/base_logger.dart';

/// Логгер который заносит описание событий в стрим
class DescriptionStreamLogger extends AppLogger {
  final AppLogger? _logger;

  StreamController<String> logStream;

  DescriptionStreamLogger({
    required this.logStream,
    AppLogger? logger,
  }) : _logger = logger;

  @override
  void log(LogEventData data) {
    logStream.add(data.description);
    _logger?.log(data);
  }
}
