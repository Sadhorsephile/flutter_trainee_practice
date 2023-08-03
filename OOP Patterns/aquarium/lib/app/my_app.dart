import 'dart:math';

import 'package:aquarium/commands/factory/duty_commands_factory.dart';
import 'package:aquarium/commands/factory/natures_event_factory.dart';
import 'package:aquarium/fish/fish_factory.dart';
import 'package:aquarium/fish/subtypes/goldfish.dart';
import 'package:aquarium/invokers/random_invoker.dart';
import 'package:aquarium/invokers/scheduled_invoker.dart';
import 'package:aquarium/logger/console_logger.dart';
import 'package:aquarium/logger/description_stream_logger.dart';
import 'package:aquarium/pool/pool.dart';
import 'package:aquarium/pool/pool_state.dart';
import 'package:aquarium/pool/staff.dart';
import 'package:aquarium/ui/pool_screen/pool_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyApp extends StatefulWidget {
  const MyApp({
    super.key,
  });

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final Pool pool;
  late final DescriptionStreamLogger logger;

  @override
  void initState() {
    logger = DescriptionStreamLogger(logger: ConsoleLogger());
    const poolCapacity = 2;
    pool = Pool(
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
    final dutyCommandsFactory =
        DutyCommandsFactory(staff: staff, logger: logger);

    /// Запуск цикла событий
    RandomInvoker(
      commandsFactory: natureCommandsFactory,
      random: random,
    ).live();

    ScheduledInvoker(
      commandsFactory: dutyCommandsFactory,
    ).live();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Provider<DescriptionStreamLogger>(
        create: (_) => logger,
        child: ChangeNotifierProvider(
          create: (context) => pool,
          child: const PoolScreen(),
        ),
      ),
    );
  }
}
