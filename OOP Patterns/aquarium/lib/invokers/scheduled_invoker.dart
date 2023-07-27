import 'package:aquarium/commands/factory/duty_commands_factory.dart';
import 'package:aquarium/invokers/invoker.dart';

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
        final dutyCommand = _dutyCommandsFactory.giveCommand();
        dutyCommand();
      }
    }
  }
}
