import 'package:aquarium/fish/fish.dart';
import 'package:aquarium/fish/fish_factory.dart';
import 'package:aquarium/fish/strategy/react_pool_strategy.dart';
import 'package:aquarium/fish/subtypes/carp_fish.dart';
import 'package:aquarium/fish/subtypes/goldfish.dart';
import 'package:aquarium/pool/pool_state.dart';
import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  /// Проверка состояний рыб
  group("Fish State test", () {
    /// Здоровое состояние
    test('Healthy state', () {
      final fish = Goldfish();
      expect(fish.state, FishState.healthy);
    });

    /// Нездоровое состояние
    test('Sick state', () {
      final fish = Goldfish();

      // Специально задаем здоровье для проверки
      fish.health = fish.maxHealth / 2;
      expect(fish.state, FishState.sick);
    });

    /// Неживое состояние
    test('Dead state', () {
      final fish = Goldfish();

      // Специально задаем здоровье для проверки
      fish.health = 0;
      expect(fish.state, FishState.dead);
    });
  });

  group('Fish eat', () {
    /// Кормление рыб
    test('Able to eat', () async {
      fakeAsync((async) {
        Fish fish = Goldfish();
        Duration timeBeforeFeed = const Duration(seconds: 3, milliseconds: 100);

        async.elapse(timeBeforeFeed);

        expect(
          fish.hunger,
          (timeBeforeFeed.inMilliseconds ~/ fish.hungerTime.inMilliseconds) *
              fish.hungerIncreasing,
        );

        expect(fish.health, fish.maxHealth - (fish.hunger * fish.hungerHarm));

        fish.feed();

        expect(fish.hunger, 0);
      });
    });

    /// Смерть из-за голодания
    test('Lethal starvation', () async {
      fakeAsync((async) {
        Fish fish = Goldfish();
        Duration timeWithoutFeed =
            const Duration(seconds: 100, milliseconds: 100);

        async.elapse(timeWithoutFeed);

        /// После продолжительного времени без кормежки рыба погибает
        expect(fish.state, FishState.dead);

        fish.feed();

        /// Невозможно покормить мертвую рыбу
        expect(fish.state, FishState.dead);
      });
    });

    group('After lifetime', () {
      /// Время жизни рыбы
      test('Fish dead after lifetime', () {
        fakeAsync((async) {
          Fish fish = Goldfish();
          Duration timeOffset = const Duration(milliseconds: 100);

          async.elapse(fish.lifetime);
          async.elapse(timeOffset);

          expect(fish.state, FishState.dead);
        });
      });
    });
  });

  group("Fish temperature reaction", () {
    /// Реакция на нормальную температуру
    test("Normal temperature reaction", () {
      final fish = Goldfish();

      fish.react(PoolState(temperature: 20, pollution: 0));

      expect(fish.health, fish.maxHealth);
    });

    /// Реакция на высокую температуру
    test("High temperature reaction", () {
      final fish = Goldfish();

      final newPoolState = PoolState(temperature: 28, pollution: 0);

      fish.react(newPoolState);

      expect(
          fish.health,
          fish.maxHealth -
              (newPoolState.temperature - fish.maxTemp) * fish.sensitivity);
    });

    /// Реакция на низкую температуру
    test("Low temperature reaction", () {
      final fish = Goldfish();

      final newPoolState = PoolState(temperature: 14, pollution: 0);

      fish.react(PoolState(temperature: 14, pollution: 0));

      expect(
          fish.health,
          fish.maxHealth -
              (fish.minTemp - newPoolState.temperature) * fish.sensitivity);
    });

    /// Смерть из-за несоблюдения температурных условий
    test("Lethal temperature condition", () {
      final fish = Goldfish();

      const veryHighTemp = 50;

      fish.react(
          PoolState(temperature: fish.maxTemp + veryHighTemp, pollution: 0));

      expect(fish.state, FishState.dead);
    });
  });

  group("Fish pollution reaction", () {
    /// Реакция на загрязнение
    test("Increase pollution reaction", () {
      final fish = Goldfish();

      final poolState = PoolState(temperature: 20, pollution: 0.1);

      fish.react(poolState);

      expect(
        fish.health,
        fish.maxHealth -
            poolState.pollution *
                PetFishReactPoolStateStrategy.pollutionHarmParam *
                fish.sensitivity,
      );

      fish.react(PoolState(temperature: 20, pollution: 0.5));
    });

    /// Смерть из-за несоблюдения условий чистоты
    test("Lethal pollution", () {
      final fish = Goldfish();

      fish
        ..react(PoolState(temperature: 20, pollution: 0.1))
        ..react(PoolState(temperature: 20, pollution: 0.5))
        ..react(PoolState(temperature: 20, pollution: 0.9));

      expect(fish.state, FishState.dead);
    });
  });

  group('Fish born', () {
    /// Размножение рыб
    test('Fish born', () {
      Fish carp = CarpFish();
      Fish goldFish = Goldfish();

      expect(carp.birth().runtimeType, carp.runtimeType);
      expect(goldFish.birth().runtimeType, goldFish.runtimeType);
    });
  });

  /// Создание рыб с помощью фабрики
  group('Fish factory test', () {
    test('Create fish', () {
      final fishFactory = EvenFishFactory();
      final fish1 = fishFactory.createFish();

      expect(fish1, isA<Fish>());

      final fish2 = fishFactory.createFish();

      expect(fish2, isA<Fish>());
    });
  });
}
