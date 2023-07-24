import 'dart:async';

import 'package:aquarium/fish/fish.dart';
import 'package:aquarium/fish/strategy/react_pool_strategy.dart';
import 'package:aquarium/pool/pool_state.dart';
import 'package:flutter/cupertino.dart';

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

  @override
  final double maxHealth = 100;

  @visibleForTesting
  @override
  late double health;

  @override
  double hunger;

  @override
  Duration hungerTime = const Duration(seconds: 1);

  @override
  Duration lifetime = const Duration(seconds: 180);

  final ReactPoolStateStrategy _reactPoolStateStrategy =
      RiverFishReactPoolStateStrategy();

  CarpFish() : hunger = 0 {
    health = maxHealth;

    /// Увеличение голода
    Timer.periodic(hungerTime, (timer) {
      /// Выключаем таймер, если рыба мертва
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
    double healthHarm = _reactPoolStateStrategy.react(this, newState);
    health -= healthHarm;
  }

  void _die() {
    health = 0;
  }
}
