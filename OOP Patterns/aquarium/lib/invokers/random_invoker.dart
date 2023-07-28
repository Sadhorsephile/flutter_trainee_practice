import 'dart:math';

import 'package:aquarium/commands/factory/natures_event_factory.dart';
import 'package:aquarium/commands/implementations/nature_events.dart';
import 'package:aquarium/invokers/invoker.dart';
import 'package:aquarium/utils/list_utils.dart';

/// Сущность, которая управляет жизнью системы
/// запуская случайные события
class RandomInvoker implements Invoker {
  /// Фабрика, которая создает ивенты, которые инвокер будет запускать
  final NatureEventFactory _natureEventFactory;

  /// Генератор случайных чисел
  final Random _random;

  /// Задержка между событиями
  static const eventDelay = Duration(seconds: 10);

  RandomInvoker({
    required NatureEventFactory commandsFactory,
    required Random random,
  })  : _natureEventFactory = commandsFactory,
        _random = random;

  @override
  Future<void> live() async {
    while (true) {
      // Рандомизируем задержку
      final durationOrder = _random.nextInt(6);
      await Future<void>.delayed(eventDelay * durationOrder);

      final natureEvent = _natureEventFactory.giveCommand(
        NatureEventsEnum.values.getRandom(
          random: _random,
        )!,
      );
      natureEvent();
    }
  }
}
