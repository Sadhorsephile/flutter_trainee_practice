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
  /// Фабрика, которая создает ивенты, которые инвокер будет запускать
  final NatureEventFactory _natureEventFactory;

  /// Генератор случайных чисел
  final Random _random;

  /// Задержка между событиями
  static const eventDelay = Duration(seconds: 1);

  RandomInvoker({
    required NatureEventFactory commandsFactory,
    required Random random,
  })  : _natureEventFactory = commandsFactory,
        _random = random;

  @override
  Future<void> live() async {
    while (true) {
      await Future<void>.delayed(eventDelay);
      final param = _random.nextInt(10);
      _natureEventFactory.giveCommand(param).execute();
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
  Future<void> live() async {
    while (true) {
      /// Выполняем каждую из трех обязанностей
      for (var i = 0; i < 3; i++) {
        await Future<void>.delayed(dutyDelay);
        _dutyCommandsFactory.giveCommand().execute();
      }
    }
  }
}
