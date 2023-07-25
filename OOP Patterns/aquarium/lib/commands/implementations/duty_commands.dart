import 'package:aquarium/commands/command.dart';
import 'package:aquarium/pool/staff.dart';

/// Команда, представляющая обязанности персонала
///
/// Реализации:
/// - [CleanPoolDuty]
/// - [ServeFishesDuty]
/// - [SetNormalTempDuty]
abstract final interface class DutyCommand extends Command {}

/// Команда для очистки бассейна
final class CleanPoolDuty implements DutyCommand {
  /// Персонал для исполнения команды
  final PoolStaff _poolStaff;

  CleanPoolDuty({required PoolStaff staff}) : _poolStaff = staff;

  @override
  void execute() => _poolStaff.cleanPool();
}


/// Команда для обслуживания рыб
final class ServeFishesDuty implements DutyCommand {
  /// Персонал для исполнения команды
  final PoolStaff _poolStaff;

  ServeFishesDuty({required PoolStaff staff}) : _poolStaff = staff;

  @override
  void execute() => _poolStaff.serveFishes();
}

/// Команда для установки нормальной температуры в бассейне
final class SetNormalTempDuty implements DutyCommand {
  /// Персонал для исполнения команды
  final PoolStaff _poolStaff;

  SetNormalTempDuty({required PoolStaff staff}) : _poolStaff = staff;

  @override
  void execute() => _poolStaff.setNormalTemperature();
}