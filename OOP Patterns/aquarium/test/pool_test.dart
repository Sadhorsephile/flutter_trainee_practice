import 'package:aquarium/fish/strategy/react_pool_strategy.dart';
import 'package:aquarium/fish/subtypes/goldfish.dart';
import 'package:aquarium/pool/pool.dart';
import 'package:aquarium/pool/pool_state.dart';
import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  /// Работа со списком рыб
  group('Fish list', () {
    /// Добавить рыбу в бассейн
    test('Add fish to the pool', () {
      final pool = Pool(
        state: const PoolState(temperature: 20, pollution: 0),
        capacity: 1,
      );
      final fish = Goldfish();
      pool.addObserver(fish);
      expect(pool.fishes, contains(fish));
    });

    /// Убрать рыбу из бассейна
    test('Remove fish from the pool', () {
      final pool = Pool(
        state: const PoolState(temperature: 20, pollution: 0),
        capacity: 1,
      );
      final fish = Goldfish();

      pool.addObserver(fish);
      pool.removeObserver(fish);

      expect(pool.fishes, isEmpty);
    });
  });

  /// Загрязнение бассейна
  test('Pool pollution', () async {
    fakeAsync((async) {
      final pool = Pool(
        state: const PoolState(temperature: 20, pollution: 0),
        capacity: 1,
      );

      /// Время загрязнения
      const pollutionTime = Duration(seconds: 1);

      async.elapse(pollutionTime);

      expect(pool.state.pollution, Pool.pollutionIncreasing);
    });
  });

  /// Изменение температуры в бассейне
  test('Change temperature', () {
    double initialTemp = 20;
    final pool = Pool(
      state: PoolState(temperature: initialTemp, pollution: 0),
      capacity: 1,
    );
    expect(pool.state.temperature, initialTemp);

    double newTemp = 30;
    pool.changeTemperature(newTemp);
    expect(pool.state.temperature, newTemp);
  });

  /// Оповещение рыб об изменениях состояния
  group('Notify fish', () {
    /// Оповещение рыб о загрязнениях
    test('Notify fishes about pollution', () {
      fakeAsync((async) {
        final pool = Pool(
          state: const PoolState(temperature: 20, pollution: 0),
          capacity: 1,
        );
        final fish = Goldfish();
        pool.addObserver(fish);

        const timeWithoutCleaning = Duration(seconds: 1, milliseconds: 100);
        async.elapse(timeWithoutCleaning);

        expect(
            pool.fishes.first.health,
            fish.maxHealth -
                Pool.pollutionIncreasing *
                    fish.sensitivity *
                    PetFishReactPoolStateStrategy.pollutionHarmParam);
      });
    });

    /// Оповещение рыб об изменениях температуры
    test('Notify fishes about temperature changing', () {
      final pool = Pool(
        state: const PoolState(temperature: 20, pollution: 0),
        capacity: 1,
      );
      final fish = Goldfish();
      pool.addObserver(fish);

      const newTemperature = 16.0;

      pool.changeTemperature(newTemperature);

      expect(fish.health,
          fish.maxHealth - (fish.minTemp - newTemperature) * fish.sensitivity);
    });
  });
}
