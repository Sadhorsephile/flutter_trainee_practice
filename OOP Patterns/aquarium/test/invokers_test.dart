import 'package:aquarium/commands/factory/duty_commands_factory.dart';
import 'package:aquarium/commands/factory/natures_event_factory.dart';
import 'package:aquarium/commands/implementations/nature_events.dart';
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
      final mockRandom = MockRandom();
      // Для задержки
      when<int>(() => mockRandom.nextInt(6)).thenReturn(1);
      // Для температуры
      when<int>(() => mockRandom.nextInt(40)).thenReturn(30);
      final commandsFactory = NatureEventFactory(
        pool: pool,
        random: mockRandom,
      );

      /// Запуск цикла событий
      RandomInvoker(
        commandsFactory: commandsFactory,
        random: mockRandom,
      ).live();

      // Проверка вызовы события изменения температуры

      // Для вызова события изменения температуры
      when<int>(() => mockRandom.nextInt(NatureEventsEnum.values.length))
          .thenReturn(NatureEventsEnum.changeTemp.index);

      async.elapse(RandomInvoker.defaultEventDelay);
      expect(pool.state.temperature,
          predicate((temp) => temp != normalTemperature));

      // Проверка вызова события рождения рыбы
      when<int>(() => mockRandom.nextInt(NatureEventsEnum.values.length))
          .thenReturn(NatureEventsEnum.bornFish.index);

      // Для выбора рыбы
      when<int>(() => mockRandom.nextInt(pool.fishes.length)).thenReturn(0);

      expect(pool.fishes.length, lessThan(poolCapacity));

      async.elapse(RandomInvoker.defaultEventDelay);
      expect(pool.fishes.length, poolCapacity);
    });
  });

  /// Тест для инвокера по расписанию
  test('Scheduled invoker test', () {
    fakeAsync((async) {
      const capacity = 2;
      final pool = Pool(
        state: const PoolState(
          temperature: normalTemperature,
          pollution: 0,
        ),
        capacity: capacity,
      );
      final fishFactory = EvenFishFactory();
      final staff = PoolStaff(
        pool: pool,
        fishFactory: fishFactory,
      );
      final commandsFactory = DutyCommandsFactory(staff: staff);

      // Изначально бассейн пуст
      expect(pool.fishes, isEmpty);

      /// Запуск цикла событий
      final invoker = ScheduledInvoker(
        commandsFactory: commandsFactory,
      )..live();

      // Проверка активности таймеров

      expect(invoker.cleanTimer.isActive, true);
      expect(invoker.serveTimer.isActive, true);
      expect(invoker.setNormalTempTimer.isActive, true);

      async.elapse(ScheduledInvoker.serveDelay);

      // После выполнения первой обязанности бассейн наполнился рыбами
      expect(pool.fishes.length, capacity);

      // За время выполнения первой обязанности бассейн загрязнился
      expect(pool.state.pollution, greaterThan(0));

      // После выполнения второй обязанности бассейн чист
      async.elapse(ScheduledInvoker.cleanDelay - ScheduledInvoker.serveDelay);
      expect(pool.state.pollution, 0);

      // Повышаем температуру вручную
      pool.changeTemperature(maxTemperature);

      expect(pool.state.temperature, maxTemperature);

      async.elapse(
          ScheduledInvoker.setNormalTempDelay - ScheduledInvoker.cleanDelay);

      // Выполнение третьей обязанности по нормализации температуры
      expect(pool.state.temperature, normalTemperature);

      // Проверка выключения инвокера

      invoker.dispose();
      expect(invoker.cleanTimer.isActive, false);
      expect(invoker.serveTimer.isActive, false);
      expect(invoker.setNormalTempTimer.isActive, false);
    });
  });
}
