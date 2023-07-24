import 'package:aquarium/fish/fish.dart';
import 'package:aquarium/fish/fish_factory.dart';
import 'package:aquarium/fish/subtypes/carp_fish.dart';
import 'package:aquarium/fish/subtypes/goldfish.dart';
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
        const poolCapacity = 8;
        final pool = Pool(
          state: PoolState(temperature: 20, pollution: 0),
          capacity: poolCapacity,
        );
        final fishFactory = EvenFishFactory();
        final staff = PoolStaff(pool: pool, fishFactory: fishFactory);

        expect(pool.fishes.length, 0);

        staff.serveFishes();

        expect(pool.fishes.length, poolCapacity);
      });
    });

    /// Кормление рыб
    test('Fish feed', () {
      fakeAsync((async) {
        final pool = Pool(
          state: PoolState(temperature: 20, pollution: 0),
          capacity: 2,
        );
        final fishFactory = EvenFishFactory();
        pool.addObserver(Goldfish());
        pool.addObserver(CarpFish());
        final staff = PoolStaff(pool: pool, fishFactory: fishFactory);

        /// Задержка, чтобы рыбы проголодались
        async.elapse(const Duration(seconds: 1));

        expect(pool.fishes[0].hunger, 20);
        expect(pool.fishes[1].hunger, 10);

        staff.serveFishes();

        expect(pool.fishes[0].hunger, 0);
        expect(pool.fishes[1].hunger, 0);
      });
    });

    /// Удаление мертвых рыб и последующее подселение новых
    test('Удаление мертвых рыб', () {
      fakeAsync((async) {
        final pool = Pool(
          state: PoolState(temperature: 20, pollution: 0),
          capacity: 2,
        );
        final fishFactory = EvenFishFactory();
        pool.addObserver(Goldfish());
        pool.addObserver(CarpFish());
        final staff = PoolStaff(pool: pool, fishFactory: fishFactory);

        /// Задержка, чтобы рыбы погибли
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
      final pool = Pool(
        state: PoolState(temperature: 20, pollution: 0),
        capacity: 2,
      );
      final fishFactory = EvenFishFactory();
      final staff = PoolStaff(pool: pool, fishFactory: fishFactory);

      pool.changeTemperature(34);

      staff.setNormalTemperature();

      expect(pool.state.temperature, normalTemperature);
    });

    test('Clean pool', () {
      fakeAsync((async) {
        final pool = Pool(
          state: PoolState(temperature: 20, pollution: 0),
          capacity: 2,
        );
        final fishFactory = EvenFishFactory();
        final staff = PoolStaff(pool: pool, fishFactory: fishFactory);

        async.elapse(const Duration(seconds: 10));

        staff.cleanPool();

        expect(pool.state.pollution, 0);
      });
    });
  });
}
