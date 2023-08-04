import 'package:aquarium/fish/fish.dart';
import 'package:aquarium/fish/subtypes/carp_fish.dart';
import 'package:aquarium/fish/subtypes/goldfish.dart';
import 'package:aquarium/logger/base_logger.dart';

/// Фабрика, которая возвращает экземпляры класса рыб
abstract class FishFactory {
  /// Получить экземпляр класса рыбы
  Fish createFish();
}

/// Фабрика, которая возвращает разные экземпляры класса рыб равномерно
class EvenFishFactory implements FishFactory {
  /// Счетчик созданных рыб
  int _count = 0;

  /// Логгер для рыб
  AppLogger logger;

  EvenFishFactory({required this.logger});

  /// Поочередно возвращает [CarpFish] и [Goldfish]
  @override
  Fish createFish() {
    _count++;
    if (_count.isEven) {
      return CarpFish(logger: logger);
    } else {
      return Goldfish(logger: logger);
    }
  }
}
