import 'package:aquarium/commands/factory/commands_factory.dart';
import 'package:aquarium/commands/implementations/duty_commands.dart';
import 'package:aquarium/pool/staff.dart';

/// Фабрика, которая возвращает команды типа [DutyCommand]
class DutyCommandsFactory implements CommandsFactory<void> {
  /// Персонал, для которого будут создаваться команды
  final PoolStaff _poolStaff;

  /// Счетчик команд для их последовательного вызова
  int _count = 0;

  DutyCommandsFactory({required PoolStaff staff}) : _poolStaff = staff;

  @override
  DutyCommand giveCommand([_]) {
    _count++;
    if (_count == 1) {
      return ServeFishesDuty(staff: _poolStaff);
    }
    if (_count == 2) {
      return CleanPoolDuty(staff: _poolStaff);
    } else {
      _count = 0;
      return SetNormalTempDuty(staff: _poolStaff);
    }
  }
}
