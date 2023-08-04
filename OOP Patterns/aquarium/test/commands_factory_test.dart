import 'package:aquarium/commands/factory/duty_commands_factory.dart';
import 'package:aquarium/commands/factory/natures_event_factory.dart';
import 'package:aquarium/commands/implementations/duty_commands.dart';
import 'package:aquarium/commands/implementations/nature_events.dart';
import 'package:aquarium/fish/fish_factory.dart';
import 'package:aquarium/logger/console_logger.dart';
import 'package:aquarium/pool/pool.dart';
import 'package:aquarium/pool/pool_state.dart';
import 'package:aquarium/pool/staff.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'mock/random_mock.dart';

void main() {
  /// Тесты для фабрики команд персонала
  group('DutyCommandsFactory tests', () {
    /// Проверка соответствия типов комманд
    test('Type correspondence for duty commands', () {
      final pool = Pool(
        state: const PoolState(
          temperature: normalTemperature,
          pollution: 0,
        ),
        capacity: 1,
      );
      final logger = ConsoleLogger();
      final fishFactory = EvenFishFactory(logger: logger);
      final staff = PoolStaff(
        pool: pool,
        fishFactory: fishFactory,
      );
      final commandsFactory = DutyCommandsFactory(staff: staff, logger: logger);

      final command1 =
          commandsFactory.giveCommand(DutyCommandsEnum.setNormalTemp);
      expect(command1, isA<DutyCommand>());
    });

    /// Проверка того, что команды выдаются в правильном порядке
    test('Duty Order', () {
      final pool = Pool(
        state: const PoolState(temperature: normalTemperature, pollution: 0),
        capacity: 1,
      );
      final logger = ConsoleLogger();
      final fishFactory = EvenFishFactory(logger: logger);
      final staff = PoolStaff(
        pool: pool,
        fishFactory: fishFactory,
      );
      final commandsFactory = DutyCommandsFactory(staff: staff, logger: logger);

      final command1 = commandsFactory.giveCommand(
        DutyCommandsEnum.serveFishes,
      );
      final command2 = commandsFactory.giveCommand(
        DutyCommandsEnum.cleanPool,
      );
      final command3 = commandsFactory.giveCommand(
        DutyCommandsEnum.setNormalTemp,
      );

      expect(command1, isA<ServeFishesDuty>());
      expect(command2, isA<CleanPoolDuty>());
      expect(command3, isA<SetNormalTempDuty>());
    });
  });

  group('NatureEventFactory tests', () {
    /// Проверка соответствия типов комманд
    test('Type correspondence for duty commands', () {
      final pool = Pool(
        state: const PoolState(
          temperature: normalTemperature,
          pollution: 0,
        ),
        capacity: 1,
      );
      final logger = ConsoleLogger();
      final random = MockRandom();
      final commandsFactory =
          NatureEventFactory(pool: pool, logger: logger, random: random);
      // Для получения природного события
      when<int>(() => random.nextInt(NatureEventsEnum.values.length))
          .thenReturn(NatureEventsEnum.changeTemp.index);

      final command = commandsFactory.giveCommand(NatureEventsEnum.changeTemp);
      expect(command, isA<NatureEvent>());
    });

    /// Различные варианты команд
    test('Type correspondence for duty commands', () {
      final pool = Pool(
        state: const PoolState(
          temperature: normalTemperature,
          pollution: 0,
        ),
        capacity: 1,
      );
      final logger = ConsoleLogger();
      final random = MockRandom();
      // Для температуры
      when<int>(() => random.nextInt(any())).thenReturn(1);
      final commandsFactory = NatureEventFactory(
        pool: pool,
        random: random,
        logger: logger,
      );

      /// В зависимости от различных параметров
      /// будут возвращаться разные типы комманд
      final command1 = commandsFactory.giveCommand(NatureEventsEnum.changeTemp);
      final command2 = commandsFactory.giveCommand(NatureEventsEnum.bornFish);
      expect(command1, isA<ChangeNatureTemperatureEvent>());
      expect(command2, isA<BornFishEvent>());
    });
  });
}
