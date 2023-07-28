import 'package:aquarium/commands/factory/commands_factory.dart';
import 'package:aquarium/commands/implementations/duty_commands.dart';
import 'package:aquarium/pool/staff.dart';

/// Фабрика, которая возвращает команды типа [DutyCommand]
class DutyCommandsFactory implements CommandsFactory<DutyCommandsEnum> {
  /// Персонал, для которого будут создаваться команды
  final PoolStaff _poolStaff;

  DutyCommandsFactory({required PoolStaff staff}) : _poolStaff = staff;

  /// Для получения команды необходимо передать [DutyCommandsEnum? command]
  @override
  DutyCommand giveCommand(DutyCommandsEnum command) {
    switch (command) {
      case DutyCommandsEnum.serveFishes:
        return ServeFishesDuty(staff: _poolStaff);
      case DutyCommandsEnum.cleanPool:
        return CleanPoolDuty(staff: _poolStaff);
      case DutyCommandsEnum.setNormalTemp:
        return SetNormalTempDuty(staff: _poolStaff);
    }
  }
}
