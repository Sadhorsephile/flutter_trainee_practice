import 'dart:math';
import 'package:aquarium/commands/command.dart';
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

  ChangeNatureTemperature({required Pool pool}) : _pool = pool;

  @override
  void execute() {
    final random = Random();
    final newTemperature = random.nextInt(40).toDouble();
    _pool.changeTemperature(newTemperature);
  }

}

/// Событие для рождения рыбы
final class BornFish implements NatureEvent {
  /// Бассейн, в котором будет выполняться событие
  final Pool _pool;

  BornFish({required Pool pool}) : _pool = pool;

  @override
  void execute() {
    final fishToBirth = _pool.fishes.getRandom();
    final newbornFish = fishToBirth?.birth();
    if (newbornFish != null) {
      _pool.addObserver(newbornFish);
    }
  }

}
