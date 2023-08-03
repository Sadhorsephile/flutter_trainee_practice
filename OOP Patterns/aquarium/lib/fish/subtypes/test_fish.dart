import 'package:aquarium/fish/fish.dart';
import 'package:aquarium/fish/strategy/react_pool_strategy.dart';
import 'package:aquarium/res/assets.dart';

/// Бессмертная рыба для дебага
class TestFish extends Fish {
  TestFish({required super.logger});

  @override
  FishAppearance get appearance => FishAppearance(
        description: 'Gold Scales',
        asset: AppAssets.goldfishAsset,
      );

  @override
  Fish birth() => TestFish(logger: super.logger);

  @override
  double get hungerHarm => 0;

  @override
  double get hungerIncreasing => 0;

  @override
  double get hungerSafeLimit => 0;

  @override
  Duration get hungerTime => Duration(seconds: 5);

  @override
  Duration get lifetime => Duration(hours: 5);

  @override
  double get maxHealth => 100;

  @override
  double get maxTemp => 40;

  @override
  // TODO: implement minTemp
  double get minTemp => 20;

  @override
  ReactPoolStateStrategy get reactPoolStateStrategy =>
      PetFishReactPoolStateStrategy();

  @override
  double get sensitivity => 0;
}
