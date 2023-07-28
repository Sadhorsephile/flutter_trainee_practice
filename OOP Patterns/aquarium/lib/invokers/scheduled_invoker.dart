import 'dart:async';

import 'package:aquarium/commands/factory/duty_commands_factory.dart';
import 'package:aquarium/commands/implementations/duty_commands.dart';
import 'package:aquarium/invokers/invoker.dart';

/// Сущность, которая управляет жизнью системы
/// запуская события по расписанию
class ScheduledInvoker implements Invoker {
  final DutyCommandsFactory _dutyCommandsFactory;

  /// Задержка между выполнением обязанностей
  static const serveDelay = Duration(seconds: 10);

  /// Задержка между выполнением обязанностей
  static const cleanDelay = Duration(seconds: 20);

  /// Задержка между выполнением обязанностей
  static const setNormalTempDelay = Duration(seconds: 30);

  ScheduledInvoker({required DutyCommandsFactory commandsFactory})
      : _dutyCommandsFactory = commandsFactory;

  @override
  void live() {
    Timer.periodic(serveDelay, (timer) {
      final dutyCommand =
          _dutyCommandsFactory.giveCommand(DutyCommandsEnum.serveFishes);
      dutyCommand();
    });
    Timer.periodic(cleanDelay, (timer) {
      final dutyCommand =
          _dutyCommandsFactory.giveCommand(DutyCommandsEnum.cleanPool);
      dutyCommand();
    });
    Timer.periodic(setNormalTempDelay, (timer) {
      final dutyCommand =
          _dutyCommandsFactory.giveCommand(DutyCommandsEnum.setNormalTemp);
      dutyCommand();
    });
  }
}
