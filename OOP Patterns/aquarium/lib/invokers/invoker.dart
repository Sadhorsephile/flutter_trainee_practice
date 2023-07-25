import 'dart:math';

import 'package:aquarium/commands/factory/duty_commands_factory.dart';
import 'package:aquarium/commands/factory/natures_event_factory.dart';

/// Сущность для управления жизнью системы
abstract class Invoker {
  /// Запустить систему
  void live();
}

/// Сущность, которая управляет жизнью системы
/// запуская случайные события
class RandomInvoker implements Invoker {
  final NatureEventFactory _natureEventFactory;

  /// Задержка между событиями
  static const eventDelay = Duration(seconds: 1);

  RandomInvoker({required NatureEventFactory commandsFactory})
      : _natureEventFactory = commandsFactory;

  @override
  void live() {
    final random = Random();
    while (true) {
      final param = random.nextInt(10);
      final command = _natureEventFactory.giveCommand(param);
      command.execute();
      Future<void>.delayed(eventDelay);
    }
  }
}

/// Сущность, которая управляет жизнью системы
/// запуская события по расписанию
class ScheduledInvoker implements Invoker {
  final DutyCommandsFactory _dutyCommandsFactory;

  /// Задержка между выполнением обязанностей
  static const dutyDelay = Duration(seconds: 2);

  ScheduledInvoker({required DutyCommandsFactory commandsFactory})
      : _dutyCommandsFactory = commandsFactory;

  @override
  void live() {
    while (true) {
      /// Выполняем каждую из трех обязанностей
      for (int i = 0; i < 3; i++) {
        final command = _dutyCommandsFactory.giveCommand();
        command.execute();
        Future<void>.delayed(dutyDelay);
      }
    }
  }
}
