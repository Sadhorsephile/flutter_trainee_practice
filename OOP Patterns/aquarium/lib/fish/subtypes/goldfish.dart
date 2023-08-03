import 'package:aquarium/fish/fish.dart';
import 'package:aquarium/fish/strategy/react_pool_strategy.dart';
import 'package:aquarium/res/assets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Золотая рыбка.
/// Подтип рыбы.
class Goldfish extends Fish {
  @override
  final FishAppearance appearance = FishAppearance(
    description: 'Gold Scales',
    asset: AppAssets.goldfishAsset,
  );

  @override
  double get minTemp => 18;

  @override
  double get maxTemp => 26;

  @override
  double get sensitivity => 2;

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

  Goldfish({required super.logger});

  /// Паттерн "Прототип"
  @override
  Fish birth() => Goldfish(logger: logger);
}
