import 'dart:async';
import 'dart:math';

import 'package:aquarium/fish/fish.dart';
import 'package:aquarium/pool/pool_state.dart';
import 'package:flutter/foundation.dart';

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

  @visibleForTesting
  @override
  final double maxHealth = 100;

  @override
  late double health;

  @override
  double hunger;

  /// Период времени, через который у рыбы возрастет голод.
  @override
  Duration hungerTime = const Duration(milliseconds: 500);

  @override
  Duration lifetime = const Duration(seconds: 120);

  Goldfish() : hunger = 0 {
    health = maxHealth;

    /// Увеличение голода
    Timer.periodic(hungerTime, (timer) {
      /// Отменяем таймер в случае смерти рыбы
      if (state == FishState.dead) {
        timer.cancel();
        return;
      }

      hunger += 10;

      /// Если голод слишком высокий - уменьшается здоровье
      if (hunger > 50) {
        health -= hunger * 0.1;
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
