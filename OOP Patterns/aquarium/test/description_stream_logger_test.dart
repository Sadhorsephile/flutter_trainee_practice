import 'package:aquarium/commands/implementations/duty_commands.dart';
import 'package:aquarium/commands/implementations/nature_events.dart';
import 'package:aquarium/fish/fish_factory.dart';
import 'package:aquarium/logger/console_logger.dart';
import 'package:aquarium/logger/description_stream_logger.dart';
import 'package:aquarium/logger/res/log_res.dart';
import 'package:aquarium/pool/pool.dart';
import 'package:aquarium/pool/pool_state.dart';
import 'package:aquarium/pool/staff.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'mock/random_mock.dart';

void main() {
  test('Description Stream Logger test', () {
    final logger = DescriptionStreamLogger(logger: ConsoleLogger());
    final pool = Pool(
      state: const PoolState(temperature: normalTemperature, pollution: 0),
      capacity: 1,
    );
    final fishFactory = EvenFishFactory(logger: logger);
    final staff = PoolStaff(pool: pool, fishFactory: fishFactory);
    final random = MockRandom();

    const newTemp = 30;
    when<int>(() => random.nextInt(maxTemperature.toInt())).thenReturn(newTemp);

    expect(
        logger.logStream.stream,
        emitsInOrder([
          predicate<String>((item) => item.contains(LogRes.staffCleanPool)),
          predicate<String>((item) => item.contains(LogRes.staffServeFishes)),
          predicate<String>((item) => item.contains(LogRes.staffSetNormalTemp)),
          predicate<String>(
              (item) => item.contains(LogRes.changingTemp(newTemp.toDouble()))),
          predicate<String>((item) => item.contains(LogRes.fishBirth)),
        ]));

    final cleanPoolCommand = CleanPoolDuty(staff: staff, logger: logger);
    cleanPoolCommand();
    final serveFishCommand = ServeFishesDuty(staff: staff, logger: logger);
    serveFishCommand();
    final setNormalCommand = SetNormalTempDuty(staff: staff, logger: logger);
    setNormalCommand();

    final changeTemp = ChangeNatureTemperature(
      pool: pool,
      logger: logger,
      random: random,
    );
    changeTemp();

    when<int>(() => random.nextInt(pool.fishes.length)).thenReturn(0);
    final bornFish = BornFish(
      pool: pool,
      logger: logger,
      random: random,
    );
    bornFish();

    logger.dispose();
  });
}
