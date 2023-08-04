import 'dart:async';

import 'package:aquarium/fish/fish.dart';
import 'package:aquarium/pool/observable.dart';
import 'package:aquarium/pool/pool_state.dart';
import 'package:flutter/foundation.dart';

/// Класс бассейна для рыб
///
/// Является обозреваемой сущностью
/// для провайдера
/// ```
/// extends ChangeNotifier
/// ```
/// и для рыб
/// ```
/// implements AquariumObservable
/// ```
///
class Pool extends ChangeNotifier implements AquariumObservable<Fish> {
  /// Список рыб, находящихся в бассейне
  /// Они являются обозревателями
  late final List<Fish> fishes;

  /// Текущее состояние бассейна
  PoolState _state;

  /// Текущее состояние бассейна
  PoolState get state => _state;

  /// Текущее состояние бассейна
  set state(PoolState value) {
    _state = value;

    /// При изменении состояния оповестить рыб
    notifyAquariumObservers();

    /// Оповестить служателей провайдера
    notifyListeners();
  }

  /// Вместимость бассейна
  final int capacity;

  /// Время, после которого бассейн получает некоторую долю загрязнения
  static const pollutionDuration = Duration(seconds: 1);

  /// Доля, на которую загрязнение возрастает за время [pollutionDuration]
  static const pollutionIncreasing = 0.1;

  Pool({
    required PoolState state,
    required this.capacity,
  }) : _state = state {
    fishes = [];

    /// Автоматическое загрязнение
    Timer.periodic(pollutionDuration, (_) => pollute());
  }

  /// Добавить рыбу в бассейн.
  /// Она будет являться обозревателем состояния
  @override
  void addObserver(Fish observer) => fishes.add(observer);

  /// Убрать рыбу из бассейна.
  /// Она больше не будет являться обозревателем его состояния
  @override
  void removeObserver(Fish observer) => fishes.remove(observer);

  /// Уведомить всех рыб о том что изменилось состояние бассейна
  @override
  void notifyAquariumObservers() {
    for (final fish in fishes) {
      fish.react(state);
    }
  }

  /// Увеличить загрязнение
  void pollute() =>
      state = state.copyWith(pollution: state.pollution + pollutionIncreasing);

  /// Изменить значение температуры
  void changeTemperature(double newTemperature) =>
      state = state.copyWith(temperature: newTemperature);

  /// Изменить значение загрязнения
  void changePollution(double newPollution) =>
      state = state.copyWith(pollution: newPollution);
}
