import 'package:aquarium/fish/fish.dart';
import 'package:aquarium/fish/subtypes/carp_fish.dart';
import 'package:aquarium/fish/subtypes/goldfish.dart';

/// Фабрика, которая возвращает экземпляры класса рыб
abstract class FishFactory {
  /// Получить экземпляр класса рыбы
  Fish createFish();
}

/// Фабрика, которая возвращает разные экземпляры класса рыб равномерно
class EvenFishFactory implements FishFactory {
  /// Счетчик созданных рыб
  int _count = 0;

  /// Поочередно возвращает [CarpFish] и [Goldfish]
  @override
  Fish createFish() {
    _count++;
    if (_count.isEven) {
      return CarpFish();
    } else {
      return Goldfish();
    }
  }
}
