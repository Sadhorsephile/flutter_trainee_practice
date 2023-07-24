import 'package:aquarium/pool/observable.dart';
import 'package:aquarium/pool/pool_state.dart';

/// Абстрактный класс рыбы.
abstract class Fish extends AquariumObserver {
  /// Внешний вид рыбы. Отличается у разных подтипов.
  FishAppearance get appearance;

  /// Состояние рыбы. Завивисит от уровня здоровья [health]
  FishState get state {
    if (health > 70) {
      return FishState.healthy;
    } else if (health <= 0) {
      return FishState.dead;
    } else {
      return FishState.sick;
    }
  }

  /// Здоровье рыбы
  /// Значение в диапозоне [0, 100]
  double get health;

  /// Голод рыбы
  /// Значение в диапозоне [0, 100]
  double get hunger;

  /// Период времени, через который у рыбы возрастает голод.
  /// Отличается у разных подтипов.
  Duration get hungerTime;

  /// Коэффецент чуствительности рыбы к неблагоприятным условиям.
  /// От него зависит, как будет падать здоровье рыбы
  /// в неблагоприятных условиях или при старении
  /// Отличается у разных подтипов.
  /// Пример значения: 5
  double get sensitivity;

  /// Минимальная температура, которую может выдержать рыба
  /// Отличается у разных подтипов.
  double get minTemp;

  /// Максимальная температура, которую может выдержать рыба
  /// Отличается у разных подтипов.
  double get maxTemp;

  /// Время жизни рыбы
  /// Отличается у разных подтипов.
  Duration get lifetime;

  /// Кормить рыбу для уменьшения голода
  void feed();

  /// Реакция рыбы на состояние бассейна
  /// Отличается у разных подтипов.
  /// Часть паттерна "Наблюдатель"
  @override
  void react(PoolState newState);

  /// Родить новую рыбу
  /// Родиться может только рыба того же типа (наследник Fish)
  /// Часть паттерна "Прототип"
  Fish birth();
}

/// Состояние рыбы
enum FishState {
  /// Здоровая рыба
  healthy,

  /// Больная рыба
  sick,

  /// Мертвая рыба
  dead,
}

/// Класс, описывающий внешний вид рыбы
class FishAppearance {
  /// Словесное описание внешнего виды рыбы
  String? description;

  // TODO: Добавить ассет

  FishAppearance({
    this.description,
  });
}
