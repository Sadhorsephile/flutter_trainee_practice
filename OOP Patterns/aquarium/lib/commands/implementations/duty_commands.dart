import 'package:aquarium/commands/command.dart';
import 'package:aquarium/pool/staff.dart';

/// Команда, представляющая обязанности персонала
///
/// Реализации:
/// - [CleanPoolDuty]
/// - [ServeFishesDuty]
/// - [SetNormalTempDuty]
sealed class DutyCommand extends Command {
  /// Тип команды (для соответствия)
  /// При создании новых экземпляров
  /// нужно задать дополнительное поле в enum
  abstract final DutyCommandsEnum type;
}

/// Перечисление комманд персонала
enum DutyCommandsEnum {
  cleanPool,
  serveFishes,
  setNormalTemp,
}

/// Команда для очистки бассейна
class CleanPoolDuty implements DutyCommand {
  @override
  DutyCommandsEnum get type => DutyCommandsEnum.cleanPool;

  /// Персонал для исполнения команды
  final PoolStaff _poolStaff;

  CleanPoolDuty({required PoolStaff staff}) : _poolStaff = staff;

  @override
  void call() => _poolStaff.cleanPool();
}

/// Команда для обслуживания рыб
class ServeFishesDuty implements DutyCommand {
  @override
  DutyCommandsEnum get type => DutyCommandsEnum.serveFishes;

  /// Персонал для исполнения команды
  final PoolStaff _poolStaff;

  ServeFishesDuty({required PoolStaff staff}) : _poolStaff = staff;

  @override
  void call() => _poolStaff.serveFishes();
}

/// Команда для установки нормальной температуры в бассейне
class SetNormalTempDuty implements DutyCommand {
  @override
  DutyCommandsEnum get type => DutyCommandsEnum.setNormalTemp;

  /// Персонал для исполнения команды
  final PoolStaff _poolStaff;

  SetNormalTempDuty({required PoolStaff staff}) : _poolStaff = staff;

  @override
  void call() => _poolStaff.setNormalTemperature();
}
