import 'package:aquarium/commands/command.dart';
import 'package:aquarium/logger/base_logger.dart';
import 'package:aquarium/logger/res/log_res.dart';
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

  final AppLogger _appLogger;

  CleanPoolDuty({
    required PoolStaff staff,
    required AppLogger logger,
  }) : _poolStaff = staff,
       _appLogger = logger;

  @override
  void execute() {
    _poolStaff.cleanPool();
    _appLogger.log(LogEventData(dateTime: DateTime.now(), description: LogRes.staffCleanPool));
  }
}


/// Команда для обслуживания рыб
final class ServeFishesDuty implements DutyCommand {
  /// Персонал для исполнения команды
  final PoolStaff _poolStaff;

  final AppLogger _appLogger;

  ServeFishesDuty({
    required PoolStaff staff,
    required AppLogger logger,
  }) : _poolStaff = staff,
       _appLogger = logger;

  @override
  void execute() {
    _poolStaff.serveFishes();
    _appLogger.log(LogEventData(dateTime: DateTime.now(), description: LogRes.staffServeFishes));
  }
}

/// Команда для установки нормальной температуры в бассейне
final class SetNormalTempDuty implements DutyCommand {
  /// Персонал для исполнения команды
  final PoolStaff _poolStaff;

  final AppLogger _appLogger;

  SetNormalTempDuty({
    required PoolStaff staff,
    required AppLogger logger,
  }) : _poolStaff = staff,
       _appLogger = logger;

  @override
  void execute() {
    _poolStaff.setNormalTemperature();
    _appLogger.log(LogEventData(dateTime: DateTime.now(), description: LogRes.staffSetNormalTemp));
  }
}
