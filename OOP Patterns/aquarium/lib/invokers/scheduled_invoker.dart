import 'dart:async';

import 'package:aquarium/commands/factory/duty_commands_factory.dart';
import 'package:aquarium/commands/implementations/duty_commands.dart';
import 'package:aquarium/invokers/invoker.dart';
import 'package:flutter/foundation.dart';

/// Сущность, которая управляет жизнью системы
/// запуская события по расписанию
class ScheduledInvoker implements Invoker {
  /// Является для инвокер активным
  bool get isActive => _isActive;

  bool _isActive;

  final DutyCommandsFactory _dutyCommandsFactory;

  /// Задержка между выполнением обязанностей
  static const serveDelay = Duration(seconds: 10);

  /// Задержка между выполнением обязанностей
  static const cleanDelay = Duration(seconds: 20);

  /// Задержка между выполнением обязанностей
  static const setNormalTempDelay = Duration(seconds: 30);

  ScheduledInvoker({required DutyCommandsFactory commandsFactory})
      : _dutyCommandsFactory = commandsFactory,
        _isActive = false;

  @visibleForTesting
  late final Timer serveTimer;
  @visibleForTesting
  late final Timer cleanTimer;
  @visibleForTesting
  late final Timer setNormalTempTimer;

  /// Выключить инвокер
  void dispose() {
    if (_isActive) {
      serveTimer.cancel();
      cleanTimer.cancel();
      setNormalTempTimer.cancel();
      _isActive = false;
    }
  }

  @override
  void live() {
    /// Если инвокер еще не был запущен - создаем таймеры
    if (!_isActive) {
      _isActive = true;
      serveTimer = Timer.periodic(serveDelay, (timer) {
        final dutyCommand =
            _dutyCommandsFactory.giveCommand(DutyCommandsEnum.serveFishes);
        dutyCommand();
      });
      cleanTimer = Timer.periodic(cleanDelay, (timer) {
        final dutyCommand =
            _dutyCommandsFactory.giveCommand(DutyCommandsEnum.cleanPool);
        dutyCommand();
      });
      setNormalTempTimer = Timer.periodic(setNormalTempDelay, (timer) {
        final dutyCommand =
            _dutyCommandsFactory.giveCommand(DutyCommandsEnum.setNormalTemp);
        dutyCommand();
      });
    }
  }
}
