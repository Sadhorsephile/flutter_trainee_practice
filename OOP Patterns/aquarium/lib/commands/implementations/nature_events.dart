import 'dart:math';
import 'package:aquarium/commands/command.dart';
import 'package:aquarium/pool/pool.dart';
import 'package:aquarium/pool/pool_state.dart';
import 'package:aquarium/utils/list_utils.dart';

/// Команда, представляющая природные события.
///
/// Реализации
/// - [ChangeNatureTemperature]
/// - [BornFish]
sealed class NatureEvent extends Command {}

/// Событие для изменения температуры
class ChangeNatureTemperature implements NatureEvent {
  /// Бассейн, в котором будет выполняться события
  final Pool _pool;

  /// Генератор случайных чисел
  final Random _random;

  ChangeNatureTemperature({
    required Pool pool,
    required Random random,
  })  : _pool = pool,
        _random = random;

  @override
  void call() {
    final newTemperature = _random.nextInt(maxTemperature.toInt()).toDouble();
    _pool.changeTemperature(newTemperature);
  }
}

/// Событие для рождения рыбы
class BornFish implements NatureEvent {
  /// Бассейн, в котором будет выполняться событие
  final Pool _pool;

  BornFish({required Pool pool}) : _pool = pool;

  @override
  void call() {
    final fishToBirth = _pool.fishes.getRandom();
    final newbornFish = fishToBirth?.birth();
    if (newbornFish != null) {
      _pool.addObserver(newbornFish);
    }
  }
}
