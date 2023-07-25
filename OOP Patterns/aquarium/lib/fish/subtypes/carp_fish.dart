import 'package:aquarium/fish/fish.dart';
import 'package:aquarium/fish/strategy/react_pool_strategy.dart';

/// Карп.
/// Подтип рыбы.
class CarpFish extends Fish {
  @override
  final FishAppearance appearance =
      FishAppearance(description: 'Silver Scales');

  @override
  double get minTemp => 16;

  @override
  double get maxTemp => 24;

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
  double get hungerIncreasing => 10;
  @override
  double get hungerSafeLimit => 50;
  @override
  double get hungerHarm => 0.1;

  /// Паттерн "Прототип"
  @override
  Fish birth() => CarpFish();
}
