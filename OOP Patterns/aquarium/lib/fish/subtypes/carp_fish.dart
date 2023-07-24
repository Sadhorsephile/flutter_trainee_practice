import 'dart:async';
import 'dart:math';

import 'package:aquarium/fish/fish.dart';
import 'package:aquarium/pool/pool_state.dart';

/// Карп.
/// Подтип рыбы.
class CarpFish extends Fish {
  @override
  FishAppearance appearance = FishAppearance(description: 'Silver Scales');

  @override
  double get minTemp => 16.0;

  @override
  double get maxTemp => 24.0;

  @override
  double get sensitivity => 4;

  double _health;

  @override
  double get health => _health;

  set health(double value) {
    /// Здоровье рыбы не может быть меньше нуля
    if (value < 0) {
      _health = 0;
    } else {
      _health = value;
    }
  }

  @override
  double hunger;

  @override
  Duration hungerTime = const Duration(seconds: 1);

  @override
  Duration lifetime = const Duration(seconds: 180);

  CarpFish()
      : _health = 100,
        hunger = 0 {
    /// Увеличение голода
    Timer.periodic(hungerTime, (timer) {
      hunger += 10;

      /// Если голод слишком высокий - уменьшается здоровье
      if (hunger > 50) {
        health -= hunger * 0.1;
      }

      /// Выключаем таймер, если рыба мертва
      if (state == FishState.dead) {
        timer.cancel();
      }
    });

    Future.delayed(lifetime).then((value) => _die());
  }

  /// Паттерн "Прототип"
  @override
  Fish birth() => CarpFish();

  @override
  void feed() {
    if (state != FishState.dead) {
      if (state == FishState.sick) {
        // Отказ от еды - неполностью утоляют голод
        hunger = hunger / 2;
      } else {
        // Здоровые рыбы полностью утоляют голод
        hunger = 0;
      }
    }
  }

  @override
  void react(PoolState newState) {
    if (state != FishState.dead) {
      final newTemperature = newState.temperature;

      if (newTemperature > maxTemp || newTemperature < minTemp) {
        /// Ухудшение здоровья завивит от отклонения условий от нормальных
        final temperatureDeviation = min(
          (newTemperature - maxTemp).abs(),
          (minTemp - newTemperature).abs(),
        );
        health -= temperatureDeviation * sensitivity;
      }

      /// Дополнительное условие:
      /// Карп получает вред, только когда вода загрязнена больше
      /// чем на половину
      if (newState.pollution > 0.5) {
        health -= newState.pollution * sensitivity * 20;
      }
    }
  }

  void _die() {
    health = 0;
  }
}
