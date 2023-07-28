/// Паттерн "Команда"
/// Некоторое действие, которое может выполняться в системе.
/// Каждая команда имеет доступ к исполнителю запроса и логгерам.
abstract class Command {
  /// Выполнить команду
  void call();
}
