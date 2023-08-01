import 'package:aquarium/fish/fish.dart';
import 'package:aquarium/fish/fish_factory.dart';
import 'package:aquarium/fish/strategy/react_pool_strategy.dart';
import 'package:aquarium/fish/subtypes/carp_fish.dart';
import 'package:aquarium/fish/subtypes/goldfish.dart';
import 'package:aquarium/logger/print_logger.dart';
import 'package:aquarium/pool/pool_state.dart';
import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  /// Проверка состояний рыб
  group('Fish State test', () {
    /// Здоровое состояние
    test('Healthy state', () {
      final logger = ConsoleLogger();
      final fish = Goldfish(logger: logger);
      expect(fish.state, FishState.healthy);
    });

    /// Нездоровое состояние
    test('Sick state', () {
      final logger = ConsoleLogger();
      final fish = Goldfish(logger: logger);

      // Специально задаем здоровье меньше уровня для проверки
      fish.health = fish.maxHealth * healthyLimit - 1;
      expect(fish.state, FishState.sick);
    });

    /// Неживое состояние
    test('Dead state', () {
      final logger = ConsoleLogger();
      // Специально задаем здоровье для проверки
      final fish = Goldfish(logger: logger)..health = 0;

      expect(fish.state, FishState.dead);
    });
  });

  group('Fish eat', () {
    /// Кормление рыб
    test('Able to eat', () async {
      fakeAsync((async) {
        final logger = ConsoleLogger();
        final Fish fish = Goldfish(logger: logger);
        const timeBeforeFeed = Duration(seconds: 3, milliseconds: 100);

        async.elapse(timeBeforeFeed);

        /// Уровень голода по прошествии времени [timeBeforeFeed]
        final hungerIncreaseDuringTime =
            (timeBeforeFeed.inMilliseconds ~/ fish.hungerTime.inMilliseconds) *
                fish.hungerIncreasing;

        expect(
          fish.hunger,
          hungerIncreaseDuringTime,
        );

        /// Остаток здоровья после голодания
        final healthRemaining =
            fish.maxHealth - (fish.hunger * fish.hungerHarm);
        expect(fish.health, healthRemaining);

        fish.feed();

        expect(fish.hunger, 0);
      });
    });

    /// Смерть из-за голодания
    test('Lethal starvation', () async {
      fakeAsync((async) {
        final logger = ConsoleLogger();
        final Fish fish = Goldfish(logger: logger);
        const timeWithoutFeed = Duration(seconds: 100, milliseconds: 100);

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
          final logger = ConsoleLogger();
          final fish = Goldfish(logger: logger);
          const timeOffset = Duration(milliseconds: 100);

          async.elapse(fish.lifetime + timeOffset);

          expect(fish.state, FishState.dead);
        });
      });
    });
  });

  group('Fish temperature reaction', () {
    /// Реакция на нормальную температуру
    test('Normal temperature reaction', () {
      final logger = ConsoleLogger();
      final fish = Goldfish(logger: logger);
      fish.react(PoolState(
        temperature: (fish.minTemp + fish.maxTemp) / 2,
        pollution: 0,
      ));

      expect(fish.health, fish.maxHealth);
    });

    /// Реакция на высокую температуру
    test('High temperature reaction', () {
      final logger = ConsoleLogger();
      final fish = Goldfish(logger: logger);

      final newTemperature = fish.maxTemp + 2;

      final newPoolState = PoolState(
        temperature: newTemperature,
        pollution: 0,
      );

      fish.react(newPoolState);

      /// Остаток здоровья после повышения температуры до [newTemperature]
      final healthRemaining = fish.maxHealth -
          (newPoolState.temperature - fish.maxTemp) * fish.sensitivity;

      expect(
        fish.health,
        healthRemaining,
      );
    });

    /// Реакция на низкую температуру
    test('Low temperature reaction', () {
      final logger = ConsoleLogger();
      final fish = Goldfish(logger: logger);

      final newTemperature = fish.minTemp - 2;
      final newPoolState = PoolState(
        temperature: newTemperature,
        pollution: 0,
      );

      fish.react(newPoolState);

      /// Остаток здоровья после уменьшения температуры до [newTemperature]
      final healthRemaining = fish.maxHealth -
          (fish.minTemp - newPoolState.temperature) * fish.sensitivity;

      expect(
        fish.health,
        healthRemaining,
      );
    });

    /// Смерть из-за несоблюдения температурных условий
    test('Lethal temperature condition', () {
      final logger = ConsoleLogger();
      final fish = Goldfish(logger: logger);

      fish.react(PoolState(temperature: fish.maxTemp * 2, pollution: 0));

      expect(fish.state, FishState.dead);
    });
  });

  group('Fish pollution reaction', () {
    /// Реакция на загрязнение
    test('Increase pollution reaction', () {
      final logger = ConsoleLogger();
      final fish = Goldfish(logger: logger);

      final poolState = PoolState(
          temperature: (fish.minTemp + fish.maxTemp) / 2, pollution: 0.1);

      fish.react(poolState);

      /// Остаток здоровья после загрязнения
      final healthRemaining = fish.maxHealth -
          poolState.pollution *
              PetFishReactPoolStateStrategy.pollutionHarmParam *
              fish.sensitivity;

      expect(
        fish.health,
        healthRemaining,
      );
    });

    /// Смерть из-за несоблюдения условий чистоты
    test('Lethal pollution', () {
      final logger = ConsoleLogger();
      final fish = Goldfish(logger: logger);
      fish
        ..react(PoolState(
            temperature: (fish.minTemp + fish.maxTemp) / 2, pollution: 0.1))
        ..react(PoolState(
            temperature: (fish.minTemp + fish.maxTemp) / 2, pollution: 0.5))
        ..react(PoolState(
            temperature: (fish.minTemp + fish.maxTemp) / 2, pollution: 0.9));

      expect(fish.state, FishState.dead);
    });
  });

  group('Fish born', () {
    /// Размножение рыб
    test('Fish born', () {
      final logger = ConsoleLogger();
      final Fish carp = CarpFish(logger: logger);
      final Fish goldFish = Goldfish(logger: logger);

      expect(carp.birth().runtimeType, carp.runtimeType);
      expect(goldFish.birth().runtimeType, goldFish.runtimeType);
    });
  });

  /// Создание рыб с помощью фабрики
  group('Fish factory test', () {
    test('Create fish', () {
      final logger = ConsoleLogger();
      final fishFactory = EvenFishFactory(logger: logger);
      final fish1 = fishFactory.createFish();

      expect(fish1, isA<Fish>());

      final fish2 = fishFactory.createFish();

      expect(fish2, isA<Fish>());
    });
  });
}
