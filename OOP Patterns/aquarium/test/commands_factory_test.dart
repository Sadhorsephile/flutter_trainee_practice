import 'package:aquarium/commands/factory/duty_commands_factory.dart';
import 'package:aquarium/commands/factory/natures_event_factory.dart';
import 'package:aquarium/commands/implementations/duty_commands.dart';
import 'package:aquarium/commands/implementations/nature_events.dart';
import 'package:aquarium/fish/fish_factory.dart';
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
      final fishFactory = EvenFishFactory();
      final staff = PoolStaff(
        pool: pool,
        fishFactory: fishFactory,
      );
      final commandsFactory = DutyCommandsFactory(staff: staff);

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
      final fishFactory = EvenFishFactory();
      final staff = PoolStaff(
        pool: pool,
        fishFactory: fishFactory,
      );
      final commandsFactory = DutyCommandsFactory(staff: staff);

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
      final random = MockRandom();
      when<int>(() => random.nextInt(any())).thenReturn(1);
      final commandsFactory = NatureEventFactory(
        pool: pool,
        random: random,
      );

      final command = commandsFactory.giveCommand();
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
      final random = MockRandom();
      when<int>(() => random.nextInt(any())).thenReturn(1);
      final commandsFactory = NatureEventFactory(
        pool: pool,
        random: random,
      );

      /// В зависимости от различных параметров
      /// будут возвращаться разные типы комманд
      final command1 = commandsFactory.giveCommand(1);
      final command2 = commandsFactory.giveCommand(6);
      final command3 = commandsFactory.giveCommand();
      expect(command1, isA<ChangeNatureTemperature>());
      expect(command2, isA<BornFish>());
      expect(command3, isA<ChangeNatureTemperature>());
    });
  });
}
