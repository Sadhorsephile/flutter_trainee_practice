import 'dart:math';
import 'package:aquarium/commands/command.dart';
import 'package:aquarium/logger/base_logger.dart';
import 'package:aquarium/logger/res/log_res.dart';
import 'package:aquarium/pool/pool.dart';
import 'package:aquarium/utils/list_utils.dart';

/// Команда, представляющая природные события.
///
/// Реализации
/// - [ChangeNatureTemperature]
/// - [BornFish]
abstract final interface class NatureEvent extends Command {}

/// Событие для изменения температуры
final class ChangeNatureTemperature implements NatureEvent {
  /// Бассейн, в котором будет выполняться события
  final Pool _pool;

  final AppLogger _appLogger;

  ChangeNatureTemperature({
    required Pool pool,
    required AppLogger logger,
  }) : _pool = pool,
        _appLogger = logger;

  @override
  void execute() {
    final random = Random();
    final newTemperature = random.nextInt(40).toDouble();
    _pool.changeTemperature(newTemperature);
    _appLogger.log(LogEventData(dateTime: DateTime.now(), description: LogRes.changingTemp(newTemperature) ),);
  }

}

/// Событие для рождения рыбы
final class BornFish implements NatureEvent {
  /// Бассейн, в котором будет выполняться событие
  final Pool _pool;

  final AppLogger _appLogger;

  BornFish({
    required Pool pool,
    required AppLogger logger,
  }) : _pool = pool,
        _appLogger = logger;

  @override
  void execute() {
    final fishToBirth = _pool.fishes.getRandom();
    final newbornFish = fishToBirth?.birth();
    if (newbornFish != null) {
      _pool.addObserver(newbornFish);
      _appLogger.log(LogEventData(dateTime: DateTime.now(), description: LogRes.fishBirth));
    }
  }

}
