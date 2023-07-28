import 'package:aquarium/commands/command.dart';
import 'package:aquarium/pool/staff.dart';

/// Команда, представляющая обязанности персонала
///
/// Реализации:
/// - [CleanPoolDuty]
/// - [ServeFishesDuty]
/// - [SetNormalTempDuty]
sealed class DutyCommand extends Command {}

/// Перечисление комманд персонала
enum DutyCommandsEnum {
  cleanPool,
  serveFishes,
  setNormalTemp,
}

/// Команда для очистки бассейна
class CleanPoolDuty implements DutyCommand {
  /// Персонал для исполнения команды
  final PoolStaff _poolStaff;

  CleanPoolDuty({required PoolStaff staff}) : _poolStaff = staff;

  @override
  void call() => _poolStaff.cleanPool();
}

/// Команда для обслуживания рыб
class ServeFishesDuty implements DutyCommand {
  /// Персонал для исполнения команды
  final PoolStaff _poolStaff;

  ServeFishesDuty({required PoolStaff staff}) : _poolStaff = staff;

  @override
  void call() => _poolStaff.serveFishes();
}

/// Команда для установки нормальной температуры в бассейне
class SetNormalTempDuty implements DutyCommand {
  /// Персонал для исполнения команды
  final PoolStaff _poolStaff;

  SetNormalTempDuty({required PoolStaff staff}) : _poolStaff = staff;

  @override
  void call() => _poolStaff.setNormalTemperature();
}
