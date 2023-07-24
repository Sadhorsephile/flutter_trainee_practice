import 'package:aquarium/fish/fish.dart';
import 'package:aquarium/fish/fish_factory.dart';
import 'package:aquarium/pool/pool.dart';
import 'package:aquarium/pool/pool_state.dart';

/// Фасад для использования бассейна
class PoolStaff {
  /// Бассейн, с которым работает персонал
  /// Клиенты [PoolStaff] не должны на прямую обращаться к нему
  final Pool _pool;

  final FishFactory _fishFactory;

  PoolStaff({required Pool pool, required FishFactory fishFactory})
      : _pool = pool,
        _fishFactory = fishFactory;

  /// Обслужить всех рыб в аквариуме
  void serveFishes() {
    final deadFishes = [];
    for (final fish in _pool.fishes) {
      if (fish.state == FishState.dead) {
        /// Если рыба мертва, добавляем её в список для удаления
        deadFishes.add(fish);
      } else {
        /// Покормить живых
        fish.feed();
      }
    }

    /// Удаляем мертвых рыб
    _pool.fishes.removeWhere((value) => deadFishes.contains(value));

    /// Переселить рыб в резервный бассейн
    while (_pool.capacity < _pool.fishes.length) {
      _pool.fishes.removeLast();
    }

    /// Подселить рыб
    while (_pool.capacity > _pool.fishes.length) {
      Fish additionalFish = _fishFactory.createFish();
      _pool.addObserver(additionalFish);
    }
  }

  /// Установить нормальную температуру
  void setNormalTemperature() {
    _pool.changeTemperature(normalTemperature);
  }

  /// Почистить бассейн
  void cleanPool() {
    _pool.changePollution(0);
  }
}
