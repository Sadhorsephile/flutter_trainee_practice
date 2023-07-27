import 'package:aquarium/commands/factory/commands_factory.dart';
import 'package:aquarium/commands/implementations/duty_commands.dart';
import 'package:aquarium/logger/base_logger.dart';
import 'package:aquarium/pool/staff.dart';

/// Фабрика, которая возвращает команды типа [DutyCommand]
class DutyCommandsFactory implements CommandsFactory<void> {
  /// Персонал, для которого будут создаваться команды
  final PoolStaff _poolStaff;

  final AppLogger _appLogger;

  /// Счетчик команд для их последовательного вызова
  int _count = 0;

  DutyCommandsFactory({
    required PoolStaff staff,
    required AppLogger logger,
  })  : _poolStaff = staff,
        _appLogger = logger;

  @override
  DutyCommand giveCommand([_]) {
    _count++;
    if (_count == 1) {
      return ServeFishesDuty(staff: _poolStaff, logger: _appLogger);
    }
    if (_count == 2) {
      return CleanPoolDuty(staff: _poolStaff, logger: _appLogger);
    } else {
      _count = 0;
      return SetNormalTempDuty(staff: _poolStaff, logger: _appLogger);
    }
  }
}
