import 'dart:math';

import 'package:aquarium/commands/factory/natures_event_factory.dart';
import 'package:aquarium/commands/implementations/nature_events.dart';
import 'package:aquarium/invokers/invoker.dart';
import 'package:aquarium/utils/list_utils.dart';

/// Сущность, которая управляет жизнью системы
/// запуская случайные события
class RandomInvoker implements Invoker {
  /// Является для инвокер активным
  bool get isActive => _isActive;

  bool _isActive;

  /// Фабрика, которая создает ивенты, которые инвокер будет запускать
  final NatureEventFactory _natureEventFactory;

  /// Генератор случайных чисел
  final Random _random;

  /// Задержка между событиями
  static const defaultEventDelay = Duration(seconds: 5);

  RandomInvoker({
    required NatureEventFactory commandsFactory,
    required Random random,
  })  : _natureEventFactory = commandsFactory,
        _random = random,
        _isActive = false;

  /// Выключить инвокер
  void dispose() {
    _isActive = false;
  }

  @override
  Future<void> live() async {
    _isActive = true;
    while (_isActive) {
      // Рандомизируем задержку
      final durationModifier = _random.nextInt(6);
      await Future<void>.delayed(defaultEventDelay * durationModifier);

      final natureEvent = _natureEventFactory
          .giveCommand(NatureEventsEnum.values.getRandomOnNonEmpty(_random));
      natureEvent();
    }
  }
}
