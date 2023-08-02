import 'package:aquarium/commands/command.dart';

/// Сущность которая выдает команды
/// Можно параметризовать этот процесс с помощью параметра типа [T]
abstract class CommandsFactory<T extends Enum> {
  /// Выдать команду.
  Command giveCommand(T command);
}
