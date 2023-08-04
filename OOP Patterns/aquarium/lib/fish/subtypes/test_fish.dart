import 'package:aquarium/fish/fish.dart';
import 'package:aquarium/fish/strategy/react_pool_strategy.dart';
import 'package:aquarium/res/assets.dart';

/// Бессмертная рыба для дебага
class ImmortalFish extends Fish {
  ImmortalFish({required super.logger});

  @override
  FishAppearance get appearance => FishAppearance(
        description: 'Gold Scales',
        asset: AppAssets.goldfishAsset,
      );

  @override
  Fish birth() => ImmortalFish(logger: super.logger);

  @override
  double get hungerHarm => 0;

  @override
  double get hungerIncreasing => 0;

  @override
  double get hungerSafeLimit => 0;

  @override
  Duration get hungerTime => const Duration(seconds: 5);

  @override
  Duration get lifetime => const Duration(hours: 5);

  @override
  double get maxHealth => 100;

  @override
  double get maxTemp => 40;

  @override
  double get minTemp => 20;

  @override
  ReactPoolStateStrategy get reactPoolStateStrategy =>
      PetFishReactPoolStateStrategy();

  @override
  double get sensitivity => 0;
}
