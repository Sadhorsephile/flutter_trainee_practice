import 'package:aquarium/fish/fish.dart';
import 'package:aquarium/fish/strategy/react_pool_strategy.dart';
import 'package:flutter/foundation.dart';

/// Золотая рыбка.
/// Подтип рыбы.
class Goldfish extends Fish {
  @override
  final FishAppearance appearance = FishAppearance(description: 'Gold Scales');

  @override
  double get minTemp => 18;

  @override
  double get maxTemp => 26;

  @override
  double get sensitivity => 5;

  @visibleForTesting
  @override
  final double maxHealth = 100;

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

  /// Паттерн "Прототип"
  @override
  Fish birth() => Goldfish();
}
