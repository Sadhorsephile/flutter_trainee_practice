import 'package:aquarium/fish/fish.dart';
import 'package:aquarium/fish/strategy/react_pool_strategy.dart';
import 'package:flutter/foundation.dart';

/// Золотая рыбка.
/// Подтип рыбы.
class Goldfish extends Fish {
  @override
  final FishAppearance appearance = FishAppearance(description: 'Gold Scales');

  @override
  double get minTemp => 18.0;

  @override
  double get maxTemp => 26.0;

  @override
  double get sensitivity => 5;

  @visibleForTesting
  @override
  final double maxHealth = 100;

  /// Период времени, через который у рыбы возрастет голод.
  @override
  Duration get hungerTime => const Duration(milliseconds: 500);

  @override
  final Duration lifetime = const Duration(seconds: 120);

  @override
  double get hungerIncreasing => 10;
  @override
  double get hungerSafeLimit => 50;
  @override
  double get hungerHarm => 0.1;

  @override
  ReactPoolStateStrategy get reactPoolStateStrategy =>
      PetFishReactPoolStateStrategy();

  Goldfish() {
    super.health = maxHealth;

    super.reactPoolStateStrategy = reactPoolStateStrategy;

    super.hunger = 0;
    super.hungerIncreasing = hungerIncreasing;
    super.hungerSafeLimit = hungerSafeLimit;
    super.hungerHarm = hungerHarm;
    super.hungerTime = hungerTime;
  }

  /// Паттерн "Прототип"
  @override
  Fish birth() => Goldfish();
}
