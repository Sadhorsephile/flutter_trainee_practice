import 'dart:async';
import 'dart:math';

import 'package:aquarium/fish/fish.dart';
import 'package:aquarium/pool/pool_state.dart';

/// Золотая рыбка.
/// Подтип рыбы.
class Goldfish extends Fish {
  @override
  FishAppearance appearance = FishAppearance(description: 'Gold Scales');

  @override
  double get minTemp => 18.0;

  @override
  double get maxTemp => 26.0;

  @override
  double get sensitivity => 5;

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

  /// Период времени, через который у рыбы возрастет голод.
  @override
  Duration hungerTime = const Duration(milliseconds: 500);

  @override
  Duration lifetime = const Duration(seconds: 120);

  Goldfish()
      : _health = 100,
        hunger = 0 {
    /// Увеличение голода
    Timer.periodic(hungerTime, (timer) {
      hunger += 10;

      /// Если голод слишком высокий - уменьшается здоровье
      if (hunger > 50) {
        health -= hunger * 0.1;
      }

      /// Отменяем таймер в случае смерти рыбы
      if (state == FishState.dead) {
        timer.cancel();
      }
    });

    Future.delayed(lifetime).then((value) => _die());
  }

  /// Паттерн "Прототип"
  @override
  Fish birth() => Goldfish();

  @override
  void feed() {
    hunger = 0;
  }

  @override
  void react(PoolState newState) {
    if (state != FishState.dead) {
      final newTemperature = newState.temperature;

      if (newTemperature > maxTemp || newTemperature < minTemp) {
        final temperatureDeviation = min(
          (newTemperature - maxTemp).abs(),
          (minTemp - newTemperature).abs(),
        );
        health -= temperatureDeviation * sensitivity;
      }

      health -= newState.pollution * sensitivity * 20;
    }
  }

  void _die() {
    health = 0;
  }
}
