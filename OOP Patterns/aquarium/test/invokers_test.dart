import 'package:aquarium/commands/factory/duty_commands_factory.dart';
import 'package:aquarium/commands/factory/natures_event_factory.dart';
import 'package:aquarium/fish/fish_factory.dart';
import 'package:aquarium/fish/subtypes/goldfish.dart';
import 'package:aquarium/invokers/random_invoker.dart';
import 'package:aquarium/invokers/scheduled_invoker.dart';
import 'package:aquarium/pool/pool.dart';
import 'package:aquarium/pool/pool_state.dart';
import 'package:aquarium/pool/staff.dart';
import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'mock/random_mock.dart';

void main() {
  /// Тест для рандомного инвокера
  test('Random invoker test', () {
    fakeAsync((async) {
      const poolCapacity = 2;
      final pool = Pool(
        state: const PoolState(temperature: normalTemperature, pollution: 0),
        capacity: poolCapacity,
      )..addObserver(Goldfish());
      final commandsFactory = NatureEventFactory(pool: pool);
      final mockRandom = MockRandom();

      /// Запуск цикла событий
      RandomInvoker(
        commandsFactory: commandsFactory,
        random: mockRandom,
      ).live();

      // Проверка вызовы события изменения температуры

      when<int>(() => mockRandom.nextInt(10)).thenReturn(1);
      async.elapse(RandomInvoker.eventDelay);
      expect(pool.state.temperature,
          predicate((temp) => temp != normalTemperature));

      // Проверка вызова события рождения рыбы

      expect(pool.fishes.length, lessThan(poolCapacity));

      when<int>(() => mockRandom.nextInt(10)).thenReturn(8);
      async.elapse(RandomInvoker.eventDelay);
      expect(pool.fishes.length, poolCapacity);
    });
  });

  /// Тест для инвокера по расписанию
  test('Scheduled invoker test', () {
    fakeAsync((async) {
      const capacity = 2;
      final pool = Pool(
        state: const PoolState(temperature: normalTemperature, pollution: 0),
        capacity: capacity,
      );
      final fishFactory = EvenFishFactory();
      final staff = PoolStaff(pool: pool, fishFactory: fishFactory);
      final commandsFactory = DutyCommandsFactory(staff: staff);

      // Изначально бассейн пуст
      expect(pool.fishes, isEmpty);

      /// Запуск цикла событий
      ScheduledInvoker(
        commandsFactory: commandsFactory,
      ).live();

      async.elapse(ScheduledInvoker.dutyDelay);

      // После выполнения первой обязанности бассейн наполнился рыбами
      expect(pool.fishes.length, capacity);

      // За время выполнения первой обязанности бассейн загрязнился
      expect(pool.state.pollution, greaterThan(0));

      // После выполнения второй обязанности бассейн чист
      async.elapse(ScheduledInvoker.dutyDelay);
      expect(pool.state.pollution, 0);

      // Повышаем температуру вручную
      pool.changeTemperature(normalTemperature * 2);

      expect(pool.state.temperature, normalTemperature * 2);

      async.elapse(ScheduledInvoker.dutyDelay);

      // Выполнение третьей обязанности по нормализации температуры
      expect(pool.state.temperature, normalTemperature);
    });
  });
}
