import 'package:aquarium/fish/fish.dart';
import 'package:aquarium/fish/fish_factory.dart';
import 'package:aquarium/fish/subtypes/carp_fish.dart';
import 'package:aquarium/fish/subtypes/goldfish.dart';
import 'package:aquarium/logger/console_logger.dart';
import 'package:aquarium/pool/pool.dart';
import 'package:aquarium/pool/pool_state.dart';
import 'package:aquarium/pool/staff.dart';
import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Serve fishes', () {
    /// Первоначальное добавление рыб
    test('Adding first fishes', () {
      fakeAsync((async) {
        final logger = ConsoleLogger();
        const poolCapacity = 8;
        final pool = Pool(
          state: const PoolState(
            temperature: 20,
            pollution: 0,
          ),
          capacity: poolCapacity,
        );
        final fishFactory = EvenFishFactory(logger: logger);
        final staff = PoolStaff(
          pool: pool,
          fishFactory: fishFactory,
        );

        expect(pool.fishes.length, 0);

        staff.serveFishes();
        expect(pool.fishes.length, poolCapacity);
      });
    });

    /// Кормление рыб
    test('Fish feed', () {
      fakeAsync((async) {
        final logger = ConsoleLogger();
        final pool = Pool(
          state: const PoolState(
            temperature: 20,
            pollution: 0,
          ),
          capacity: 2,
        );
        final fishFactory = EvenFishFactory(logger: logger);
        pool
          ..addObserver(Goldfish(logger: logger))
          ..addObserver(CarpFish(logger: logger));
        final staff = PoolStaff(
          pool: pool,
          fishFactory: fishFactory,
        );

        /// Задержка, чтобы рыбы проголодались
        const timeBeforeFeed = Duration(seconds: 1);
        async.elapse(timeBeforeFeed);

        /// Остаток здоровья после голодания первой рыбы
        final healthRemainingFish1 = pool.fishes[0].hungerIncreasing *
            (timeBeforeFeed.inMilliseconds /
                pool.fishes[0].hungerTime.inMilliseconds);

        /// Остаток здоровья после голодания второй рыбы
        final healthRemainingFish2 = pool.fishes[1].hungerIncreasing *
            (timeBeforeFeed.inMilliseconds /
                pool.fishes[1].hungerTime.inMilliseconds);

        expect(
          pool.fishes[0].hunger,
          healthRemainingFish1,
        );
        expect(
          pool.fishes[1].hunger,
          healthRemainingFish2,
        );

        staff.serveFishes();

        expect(pool.fishes[0].hunger, 0);
        expect(pool.fishes[1].hunger, 0);
      });
    });

    /// Удаление мертвых рыб и последующее подселение новых
    test('Удаление мертвых рыб', () {
      fakeAsync((async) {
        final logger = ConsoleLogger();
        final pool = Pool(
          state: const PoolState(
            temperature: 20,
            pollution: 0,
          ),
          capacity: 2,
        );
        final fishFactory = EvenFishFactory(logger: logger);
        pool
          ..addObserver(Goldfish(logger: logger))
          ..addObserver(CarpFish(logger: logger));
        final staff = PoolStaff(
          pool: pool,
          fishFactory: fishFactory,
        );

        /// Задержка в кормежке, из-за которой рыбы погибнут
        async.elapse(const Duration(seconds: 100));

        expect(pool.fishes[0].state, FishState.dead);
        expect(pool.fishes[1].state, FishState.dead);

        staff.serveFishes();

        expect(pool.fishes[0].state, FishState.healthy);
        expect(pool.fishes[1].state, FishState.healthy);
      });
    });
  });

  group('Pool service', () {
    test('Temperature normalization', () {
      final logger = ConsoleLogger();
      final pool = Pool(
        state: const PoolState(
          temperature: 20,
          pollution: 0,
        ),
        capacity: 2,
      );
      final fishFactory = EvenFishFactory(logger: logger);
      final staff = PoolStaff(
        pool: pool,
        fishFactory: fishFactory,
      );
      const newTemperature = 34.0;

      pool.changeTemperature(newTemperature);
      expect(pool.state.temperature, newTemperature);

      staff.setNormalTemperature();
      expect(pool.state.temperature, normalTemperature);
    });

    test('Clean pool', () {
      fakeAsync((async) {
        final logger = ConsoleLogger();
        final pool = Pool(
          state: const PoolState(
            temperature: 20,
            pollution: 0,
          ),
          capacity: 2,
        );
        final fishFactory = EvenFishFactory(logger: logger);
        final staff = PoolStaff(
          pool: pool,
          fishFactory: fishFactory,
        );

        const timeBeforeCleaning = Duration(seconds: 10);
        async.elapse(timeBeforeCleaning);

        staff.cleanPool();
        expect(pool.state.pollution, 0);
      });
    });
  });
}
