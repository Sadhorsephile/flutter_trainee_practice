import 'package:aquarium/commands/implementations/duty_commands.dart';
import 'package:aquarium/commands/implementations/nature_events.dart';
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
  /// Тесты комманд персонала
  group('DutyCommand tests', () {
    /// Тест команды для очистки бассейна
    test('CleanPoolDuty test', () {
      fakeAsync((async) {
        final pool = Pool(
          state: const PoolState(temperature: normalTemperature, pollution: 0),
          capacity: 1,
        );
        final fishFactory = EvenFishFactory();
        final staff = PoolStaff(pool: pool, fishFactory: fishFactory);

        const timeWithoutCleaning = Duration(seconds: 10);
        async.elapse(timeWithoutCleaning);
        expect(pool.state.pollution, greaterThan(0));

        final cleanPoolCommand = CleanPoolDuty(staff: staff);
        cleanPoolCommand();
        expect(pool.state.pollution, 0);
      });
    });

    /// Тест команды для установки нормальной температуры
    test('SetNormalTempDuty test', () {
      final pool = Pool(
        state: const PoolState(temperature: normalTemperature, pollution: 0),
        capacity: 1,
      );
      final fishFactory = EvenFishFactory();
      final staff = PoolStaff(pool: pool, fishFactory: fishFactory);

      pool.changeTemperature(normalTemperature * 2);
      expect(pool.state.temperature, normalTemperature * 2);

      final setNormalTempCommand = SetNormalTempDuty(staff: staff);
      setNormalTempCommand();
      expect(pool.state.temperature, normalTemperature);
    });

    /// Тест команды для ухода за рыбами
    test('ServeFishesDuty test', () {
      fakeAsync((async) {
        const poolCapacity = 2;
        final pool = Pool(
          state: const PoolState(temperature: normalTemperature, pollution: 0),
          capacity: poolCapacity,
        );
        final fishFactory = EvenFishFactory();
        final staff = PoolStaff(pool: pool, fishFactory: fishFactory);

        // Первоначальное заполнение бассейна рыбами

        expect(pool.fishes, isEmpty);

        final serveFishesCommand = ServeFishesDuty(staff: staff);
        serveFishesCommand();
        expect(pool.fishes.length, poolCapacity);

        // Кормление рыб

        /// Задержка, чтобы рыбы проголодались
        const timeBeforeFeed = Duration(seconds: 1);
        async.elapse(timeBeforeFeed);

        expect(
          pool.fishes[0].hunger,
          pool.fishes[0].hungerIncreasing *
              (timeBeforeFeed.inMilliseconds /
                  pool.fishes[0].hungerTime.inMilliseconds),
        );
        expect(
          pool.fishes[1].hunger,
          pool.fishes[1].hungerIncreasing *
              (timeBeforeFeed.inMilliseconds /
                  pool.fishes[1].hungerTime.inMilliseconds),
        );

        serveFishesCommand();

        expect(pool.fishes[0].hunger, 0);
        expect(pool.fishes[1].hunger, 0);

        // Удаление мертвых рыб

        /// Задержка в кормежке, из-за которой рыбы погибнут
        async.elapse(const Duration(seconds: 100));

        expect(pool.fishes[0].state, FishState.dead);
        expect(pool.fishes[1].state, FishState.dead);

        serveFishesCommand();

        expect(pool.fishes[0].state, FishState.healthy);
        expect(pool.fishes[1].state, FishState.healthy);

        // Переселение лишних рыб

        pool
          ..addObserver(Goldfish())
          ..addObserver(CarpFish());

        expect(pool.fishes.length, greaterThan(poolCapacity));

        serveFishesCommand();

        expect(pool.fishes.length, poolCapacity);
      });
    });
  });

  /// Тесты прородных событий
  group('NatureEvent tests', () {
    /// Тест для случайного изменения температуры
    test('ChangeNatureTemperature test', () {
      final pool = Pool(
        state: const PoolState(temperature: normalTemperature, pollution: 0),
        capacity: 1,
      );

      expect(pool.state.temperature, normalTemperature);

      final changeTempCommand = ChangeNatureTemperature(pool: pool);
      changeTempCommand();

      expect(pool.state.temperature,
          predicate((temp) => temp != normalTemperature));
    });

    /// Тест для рождения рыбы
    test('BornFish test', () {
      final pool = Pool(
        state: const PoolState(temperature: normalTemperature, pollution: 0),
        capacity: 1,
      );

      // Пустой аквариум

      final bornFish = BornFish(pool: pool);
      bornFish();

      // В пустом аквариуме рыб родиться не может
      expect(pool.fishes, isEmpty);

      // Добавить рыбу в аквариум

      pool.addObserver(Goldfish());
      expect(pool.fishes.length, 1);

      bornFish();
      expect(pool.fishes.length, 2);
      expect(pool.fishes.first.runtimeType, pool.fishes.last.runtimeType);
    });
  });
}
