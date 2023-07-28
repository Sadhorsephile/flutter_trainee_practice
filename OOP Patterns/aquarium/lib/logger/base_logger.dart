abstract class AppLogger {
  void log(LogEventData data);
}

class LogEventData {
  // Object actor;
  // String action;
  DateTime dateTime;
  String description;

  LogEventData({
    required this.dateTime,
    required this.description,
  });
}
