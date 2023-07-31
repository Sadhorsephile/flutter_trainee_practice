import 'package:aquarium/commands/factory/commands_factory.dart';
import 'package:aquarium/commands/implementations/duty_commands.dart';
import 'package:aquarium/logger/base_logger.dart';
import 'package:aquarium/pool/staff.dart';

/// Фабрика, которая возвращает команды типа [DutyCommand]
class DutyCommandsFactory implements CommandsFactory<DutyCommandsEnum> {
  /// Персонал, для которого будут создаваться команды
  final PoolStaff _poolStaff;

  /// Логгер для событий
  final AppLogger _appLogger;

  DutyCommandsFactory({
    required PoolStaff staff,
    required AppLogger logger,
  })  : _poolStaff = staff,
        _appLogger = logger;

  /// Для получения команды необходимо передать [DutyCommandsEnum? command]
  @override
  DutyCommand giveCommand(DutyCommandsEnum command) {
    switch (command) {
      case DutyCommandsEnum.serveFishes:
        return ServeFishesDuty(staff: _poolStaff, logger: _appLogger);
      case DutyCommandsEnum.cleanPool:
        return CleanPoolDuty(staff: _poolStaff, logger: _appLogger);
      case DutyCommandsEnum.setNormalTemp:
        return SetNormalTempDuty(staff: _poolStaff, logger: _appLogger);
    }
  }
}
