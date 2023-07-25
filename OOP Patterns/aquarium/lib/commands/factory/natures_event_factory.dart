import 'package:aquarium/commands/factory/commands_factory.dart';
import 'package:aquarium/commands/implementations/nature_events.dart';
import 'package:aquarium/pool/pool.dart';

/// Фабрика, которая возвращает команды типа [NatureEvent]
class NatureEventFactory extends CommandsFactory<int?> {
  /// Бассейн, для которого будут создаваться события
  final Pool _pool;

  NatureEventFactory({required Pool pool}) : _pool = pool;

  /// Необходимо передать в качестве параметра целое число (случайное)
  ///
  /// Если число меньше 5 или вообще не передано (null),
  /// то возвращает событие [ChangeNatureTemperature]
  /// Иначе возвращает событие [BornFish]
  @override
  NatureEvent giveCommand([int? param]) {
    if (param == null) {
      return ChangeNatureTemperature(pool: _pool);
    }
    if (param <= 5) {
      return ChangeNatureTemperature(pool: _pool);
    } else {
      return BornFish(pool: _pool);
    }
  }
}
