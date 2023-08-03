import 'dart:math';

import 'package:aquarium/commands/factory/duty_commands_factory.dart';
import 'package:aquarium/commands/factory/natures_event_factory.dart';
import 'package:aquarium/fish/fish_factory.dart';
import 'package:aquarium/fish/subtypes/goldfish.dart';
import 'package:aquarium/invokers/random_invoker.dart';
import 'package:aquarium/invokers/scheduled_invoker.dart';
import 'package:aquarium/logger/console_logger.dart';
import 'package:aquarium/pool/pool.dart';
import 'package:aquarium/pool/pool_state.dart';
import 'package:aquarium/pool/staff.dart';
import 'package:aquarium/ui/pool_screen/pool_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  final logger = ConsoleLogger();
  const poolCapacity = 2;
  final pool = Pool(
    state: const PoolState(temperature: normalTemperature, pollution: 0),
    capacity: poolCapacity,
  )..addObserver(Goldfish(logger: logger));
  final fishFactory = EvenFishFactory(logger: logger);
  final staff = PoolStaff(
    pool: pool,
    fishFactory: fishFactory,
  );
  final random = Random();
  final natureCommandsFactory = NatureEventFactory(
    pool: pool,
    logger: logger,
    random: random,
  );
  final dutyCommandsFactory = DutyCommandsFactory(staff: staff, logger: logger);

  /// Запуск цикла событий
  RandomInvoker(
    commandsFactory: natureCommandsFactory,
    random: random,
  ).live();

  ScheduledInvoker(
    commandsFactory: dutyCommandsFactory,
  ).live();

  runApp(MyApp(pool: pool));
}

class MyApp extends StatelessWidget {
  final Pool pool;
  const MyApp({super.key, required this.pool});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChangeNotifierProvider(
        create: (context) => pool,
        child: const PoolScreen(),
      ),
    );
  }
}
