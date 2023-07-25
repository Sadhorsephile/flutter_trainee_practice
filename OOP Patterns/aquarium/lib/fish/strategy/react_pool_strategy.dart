import 'dart:math';

import 'package:aquarium/fish/fish.dart';
import 'package:aquarium/pool/pool_state.dart';

/// Стратегия реакций рыб на состояния бассейна
abstract class ReactPoolStateStrategy {
  /// Реакция рыбы [fish] на новые условия в бассейне [poolState]
  /// Возвращает вред нанесенный здоровью
  double react(Fish fish, PoolState poolState);
}

/// Реакция речных рыб на изменение условий бассейна
class RiverFishReactPoolStateStrategy implements ReactPoolStateStrategy {
  /// Коэффецент получения урона от загрязнения
  static const pollutionHarmParam = 20;

  @override
  double react(Fish fish, PoolState poolState) {
    var healthHarm = 0.0;

    final state = fish.state;
    final maxTemp = fish.maxTemp;
    final minTemp = fish.minTemp;
    final sensitivity = fish.sensitivity;

    if (state != FishState.dead) {
      final newTemperature = poolState.temperature;

      if (newTemperature > maxTemp || newTemperature < minTemp) {
        /// Ухудшение здоровья завивит от отклонения условий от нормальных
        final temperatureDeviation = min(
          (newTemperature - maxTemp).abs(),
          (minTemp - newTemperature).abs(),
        );
        healthHarm += temperatureDeviation * sensitivity;
      }

      /// Дополнительное условие:
      /// Речная рыба получает вред, только когда вода загрязнена больше
      /// чем на половину
      if (poolState.pollution > 0.5) {
        healthHarm += poolState.pollution * sensitivity * pollutionHarmParam;
      }
    }

    return healthHarm;
  }
}

/// Реакция домашних рыб на загрязнение
class PetFishReactPoolStateStrategy implements ReactPoolStateStrategy {
  /// Коэффецент получения урона от загрязнения
  static const pollutionHarmParam = 20;

  @override
  double react(Fish fish, PoolState poolState) {
    var healthHarm = 0.0;

    final state = fish.state;
    final maxTemp = fish.maxTemp;
    final minTemp = fish.minTemp;
    final sensitivity = fish.sensitivity;

    if (state != FishState.dead) {
      final newTemperature = poolState.temperature;

      if (newTemperature > maxTemp || newTemperature < minTemp) {
        final temperatureDeviation = min(
          (newTemperature - maxTemp).abs(),
          (minTemp - newTemperature).abs(),
        );
        healthHarm += temperatureDeviation * sensitivity;
      }

      healthHarm += poolState.pollution * sensitivity * pollutionHarmParam;
    }

    return healthHarm;
  }
}
