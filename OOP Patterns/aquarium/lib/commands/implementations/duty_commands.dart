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

  final AppLogger _appLogger;

  CleanPoolDuty({
    required PoolStaff staff,
    required AppLogger logger,
  }) : _poolStaff = staff,
       _appLogger = logger;

  @override
  void call() {
    _poolStaff.cleanPool();
    _appLogger.log(LogEventData(dateTime: DateTime.now(), description: LogRes.staffCleanPool));
  }
}

/// Команда для обслуживания рыб
class ServeFishesDuty implements DutyCommand {
  @override
  DutyCommandsEnum get type => DutyCommandsEnum.serveFishes;

  /// Персонал для исполнения команды
  final PoolStaff _poolStaff;

  final AppLogger _appLogger;

  ServeFishesDuty({
    required PoolStaff staff,
    required AppLogger logger,
  }) : _poolStaff = staff,
       _appLogger = logger;

  @override
  void call() {
    _poolStaff.serveFishes();
    _appLogger.log(LogEventData(dateTime: DateTime.now(), description: LogRes.staffServeFishes));
  }
}

/// Команда для установки нормальной температуры в бассейне
class SetNormalTempDuty implements DutyCommand {
  @override
  DutyCommandsEnum get type => DutyCommandsEnum.setNormalTemp;

  /// Персонал для исполнения команды
  final PoolStaff _poolStaff;

  final AppLogger _appLogger;

  SetNormalTempDuty({
    required PoolStaff staff,
    required AppLogger logger,
  }) : _poolStaff = staff,
       _appLogger = logger;

  @override
  void call() {
    _poolStaff.setNormalTemperature();
    _appLogger.log(LogEventData(dateTime: DateTime.now(), description: LogRes.staffSetNormalTemp));
  }
}
