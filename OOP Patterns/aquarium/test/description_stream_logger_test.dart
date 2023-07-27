import 'dart:async';

import 'package:aquarium/commands/implementations/duty_commands.dart';
import 'package:aquarium/commands/implementations/nature_events.dart';
import 'package:aquarium/fish/fish_factory.dart';
import 'package:aquarium/logger/description_stream_logger.dart';
import 'package:aquarium/logger/res/log_res.dart';
import 'package:aquarium/pool/pool.dart';
import 'package:aquarium/pool/pool_state.dart';
import 'package:aquarium/pool/staff.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Description Stream Logger test', () {
    final logStream = StreamController<String>();
    final logger = DescriptionStreamLogger(logStream: logStream);
    final pool = Pool(
      state: const PoolState(temperature: normalTemperature, pollution: 0),
      capacity: 1,
    );
    final fishFactory = EvenFishFactory();
    final staff = PoolStaff(pool: pool, fishFactory: fishFactory);
    expect(
        logStream.stream,
        emitsInOrder([
          LogRes.staffCleanPool,
          LogRes.staffServeFishes,
          LogRes.staffSetNormalTemp,
          //LogRes.changingTemp(temp)
          LogRes.fishBirth,
        ]));

    CleanPoolDuty(staff: staff, logger: logger).execute();
    ServeFishesDuty(staff: staff, logger: logger).execute();
    SetNormalTempDuty(staff: staff, logger: logger).execute();

    //ChangeNatureTemperature(pool: pool, logger: logger).execute();
    BornFish(pool: pool, logger: logger).execute();

    logStream.close();
  });
}
