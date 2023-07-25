import 'dart:async';

import 'package:aquarium/fish/strategy/react_pool_strategy.dart';
import 'package:aquarium/pool/observable.dart';
import 'package:aquarium/pool/pool_state.dart';
import 'package:flutter/foundation.dart';

/// Абстрактный класс рыбы.
abstract class Fish extends AquariumObserver {
  /// Внешний вид рыбы. Отличается у разных подтипов.
  FishAppearance get appearance;

  /// Состояние рыбы. Завивисит от уровня здоровья [health]
  FishState get state {
    if (health > maxHealth * 0.7) {
      return FishState.healthy;
    } else if (health <= 0) {
      return FishState.dead;
    } else {
      return FishState.sick;
    }
  }

  /// Максимальное здоровье рыбы
  /// Пример: 100
  double get maxHealth;

  /// Текущее здоровье рыбы
  /// Значение в диапозоне [0, maxHealth]
  @visibleForTesting
  @protected
  late double health;

  /// Голод рыбы
  /// Значение в диапозоне [0, 100]
  @visibleForTesting
  @protected
  late double hunger;

  /// Период времени, через который у рыбы возрастает голод.
  /// Отличается у разных подтипов.
  late Duration hungerTime;

  /// Коэффецент чуствительности рыбы к неблагоприятным условиям.
  /// От него зависит, как будет падать здоровье рыбы
  /// в неблагоприятных условиях
  /// Отличается у разных подтипов.
  /// Пример значения: 5
  double get sensitivity;

  /// Минимальная температура, которую может выдержать рыба
  /// Отличается у разных подтипов.
  /// Пример: 18
  double get minTemp;

  /// Максимальная температура, которую может выдержать рыба
  /// Отличается у разных подтипов.
  /// Пример: 25
  double get maxTemp;

  /// Время жизни рыбы
  /// Отличается у разных подтипов.
  Duration get lifetime;

  /// Количество единиц на которые возрастает голод
  /// Пример: 10
  late double hungerIncreasing;

  /// Предел голода, до которого рыба не получает вреда
  /// Пример: 50
  late double hungerSafeLimit;

  /// Коэффициент, с которым рыба получает урон от голода
  /// Пример: 0.1
  late double hungerHarm;

  /// Стратегия реакций рыб на состояния бассейна.
  /// На её основе высчитывается урон здоровью.
  late ReactPoolStateStrategy reactPoolStateStrategy;

  Fish() {
    /// Увеличение голода
    launchHungerTimer();

    /// Естественная смерть рыбы по истечению времени жизни
    Future.delayed(lifetime).then((value) => health = 0);
  }

  /// Запустить таймер, по которому рыба будет хотеть есть
  /// Потомки могут переопределить эту логику
  @protected
  void launchHungerTimer() {
    Timer.periodic(hungerTime, (timer) {
      /// Выключаем таймер, если рыба мертва
      if (state == FishState.dead) {
        timer.cancel();
        return;
      }

      hunger += hungerIncreasing;

      /// Если голод слишком высокий - уменьшается здоровье
      if (hunger > hungerSafeLimit) {
        health -= hunger * hungerHarm;
      }
    });
  }

  /// Кормить рыбу для уменьшения голода
  void feed() {
    if (state != FishState.dead) {
      if (state == FishState.sick) {
        // Больные рыбы отказываются от еды - неполностью утоляют голод
        hunger = hunger / 2;
      } else {
        // Здоровые рыбы полностью утоляют голод
        hunger = 0;
      }
    }
  }

  /// Реакция рыбы на состояние бассейна
  /// Отличается у разных подтипов.
  /// Часть паттерна "Наблюдатель"
  @override
  void react(PoolState newState) {
    double healthHarm = reactPoolStateStrategy.react(this, newState);
    health -= healthHarm;
  }

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
