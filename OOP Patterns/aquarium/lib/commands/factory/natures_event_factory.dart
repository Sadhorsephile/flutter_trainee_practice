import 'dart:math';

import 'package:aquarium/commands/factory/commands_factory.dart';
import 'package:aquarium/commands/implementations/nature_events.dart';
import 'package:aquarium/logger/base_logger.dart';
import 'package:aquarium/pool/pool.dart';

/// Фабрика, которая возвращает команды типа [NatureEvent]
class NatureEventFactory extends CommandsFactory<NatureEventsEnum> {
  /// Бассейн, для которого будут создаваться события
  final Pool _pool;

  /// Генератор случайных чисел
  final Random _random;

  /// Логгер для событий
  final AppLogger _appLogger;

  NatureEventFactory({
    required Pool pool,
    required Random random,
    required AppLogger logger,
  })  : _pool = pool,
        _random = random,
        _appLogger = logger;

  @override
  NatureEvent giveCommand(NatureEventsEnum command) {
    switch (command) {
      case NatureEventsEnum.bornFish:
        return BornFish(
          pool: _pool,
          random: _random,
          logger: _appLogger,
        );
      case NatureEventsEnum.changeTemp:
        return ChangeNatureTemperature(
          pool: _pool,
          random: _random,
          logger: _appLogger,
        );
    }
  }
}
