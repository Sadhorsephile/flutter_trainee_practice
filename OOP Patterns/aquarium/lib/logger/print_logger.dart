import 'package:aquarium/logger/base_logger.dart';
import 'package:flutter/foundation.dart';

class PrintLogger extends AppLogger {
  @override
  void log(LogEventData data) {
    if (kDebugMode) {
      print('${data.dateTime} : ${data.description}');
    }
  }
}
