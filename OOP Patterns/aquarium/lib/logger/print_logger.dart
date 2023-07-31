import 'package:aquarium/logger/base_logger.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class PrintLogger extends AppLogger {
  /// Вложенный логгер для событий
  @override
  final AppLogger? logger;

  /// Формат для строки данных
  static DateFormat formatter = DateFormat('dd.MM.yyyy hh:mm:ss');

  PrintLogger({
    this.logger,
  });

  @override
  void log(LogEventData data) {
    if (kDebugMode) {
      print('${formatter.format(data.dateTime)} : ${data.description}');
    }
    super.log(data);
  }
}
