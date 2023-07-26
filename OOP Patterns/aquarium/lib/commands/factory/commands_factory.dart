import 'package:aquarium/commands/command.dart';

/// Сущность которая выдает команды
/// Можно параметризовать этот процесс с помощью параметра типа [T]
abstract class CommandsFactory<T> {
  /// Выдать команду.
  /// Можно использовать необязательный параметр [param].
  Command giveCommand([T param]);
}
