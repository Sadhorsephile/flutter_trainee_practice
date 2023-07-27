import 'package:aquarium/commands/factory/commands_factory.dart';
import 'package:aquarium/commands/implementations/nature_events.dart';
import 'package:aquarium/logger/base_logger.dart';
import 'package:aquarium/pool/pool.dart';

/// Фабрика, которая возвращает команды типа [NatureEvent]
class NatureEventFactory extends CommandsFactory<int?> {
  /// Бассейн, для которого будут создаваться события
  final Pool _pool;

  final AppLogger _appLogger;

  NatureEventFactory({
    required Pool pool,
    required AppLogger logger,
  })  : _pool = pool,
        _appLogger = logger;

  /// Необходимо передать в качестве параметра целое число (случайное)
  ///
  /// Если число меньше 5 или вообще не передано (null),
  /// то возвращает событие [ChangeNatureTemperature]
  /// Иначе возвращает событие [BornFish]
  @override
  NatureEvent giveCommand([int? param]) {
    if (param == null) {
      return ChangeNatureTemperature(pool: _pool, logger: _appLogger);
    }
    if (param <= 5) {
      return ChangeNatureTemperature(pool: _pool, logger: _appLogger);
    } else {
      return BornFish(pool: _pool, logger: _appLogger);
    }
  }
}
