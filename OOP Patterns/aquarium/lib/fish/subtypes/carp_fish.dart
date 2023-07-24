import 'package:aquarium/fish/fish.dart';
import 'package:aquarium/fish/strategy/react_pool_strategy.dart';

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

  @override
  Duration get hungerTime => const Duration(seconds: 1);

  @override
  final Duration lifetime = const Duration(seconds: 180);

  @override
  ReactPoolStateStrategy get reactPoolStateStrategy =>
      RiverFishReactPoolStateStrategy();

  @override
  double get hungerIncrease => 10;
  @override
  double get hungerLimit => 50;
  @override
  double get hungerHarm => 0.1;

  CarpFish() {
    super.health = maxHealth;

    super.reactPoolStateStrategy = reactPoolStateStrategy;

    super.hunger = 0;
    super.hungerIncrease = hungerIncrease;
    super.hungerLimit = hungerLimit;
    super.hungerHarm = hungerHarm;
    super.hungerTime = hungerTime;
  }

  /// Паттерн "Прототип"
  @override
  Fish birth() => CarpFish();
}
