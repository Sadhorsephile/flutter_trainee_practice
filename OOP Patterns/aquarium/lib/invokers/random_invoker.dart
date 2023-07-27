import 'dart:math';

import 'package:aquarium/commands/factory/natures_event_factory.dart';
import 'package:aquarium/invokers/invoker.dart';

/// Сущность, которая управляет жизнью системы
/// запуская случайные события
class RandomInvoker implements Invoker {
  /// Фабрика, которая создает ивенты, которые инвокер будет запускать
  final NatureEventFactory _natureEventFactory;

  /// Генератор случайных чисел
  final Random _random;

  /// Задержка между событиями
  static const eventDelay = Duration(seconds: 1);

  RandomInvoker({
    required NatureEventFactory commandsFactory,
    required Random random,
  })  : _natureEventFactory = commandsFactory,
        _random = random;

  @override
  Future<void> live() async {
    while (true) {
      await Future<void>.delayed(eventDelay);
      final param = _random.nextInt(10);
      final natureEvent = _natureEventFactory.giveCommand(param);
      natureEvent();
    }
  }
}
