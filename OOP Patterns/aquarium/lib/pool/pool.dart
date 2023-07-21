import 'dart:async';

import 'package:aquarium/fish/fish.dart';
import 'package:aquarium/pool/observable.dart';
import 'package:aquarium/pool/pool_state.dart';

/// Класс бассейна для рыб
class Pool implements AquariumObservable<Fish> {
  /// Список рыб, находящихся в бассейне
  /// Они являются обозревателями
  late List<Fish> fishes;

  /// Текущее состояние бассейна
  PoolState _state;

  PoolState get state => _state;

  set state(PoolState value) {
    _state = value;
    notifyObservers();
  }

  /// Вместимость бассейна
  int capacity;

  /// Время, после которого бассейн получает некоторую долю загрязнения
  static const pollutionDuration = Duration(seconds: 1);

  Pool({
    required PoolState state,
    required this.capacity,
  }) : _state = state {
    fishes = [];

    /// Автоматическое загрязнение
    Timer.periodic(pollutionDuration, (Timer t) {
      _pollute();
    });
  }

  /// Добавить рыбу в бассейн.
  /// Она будет являться обозревателем состояния
  @override
  void addObserver(Fish observer) {
    fishes.add(observer);
  }

  /// Убрать рыбу из бассейна.
  /// Она больше не будет являться обозревателем его состояния
  @override
  void removeObserver(Fish observer) {
    fishes.remove(observer);
  }

  /// Уведомить всех рыб о том что изменилось состояние бассейна
  @override
  void notifyObservers() {
    for (final fish in fishes) {
      fish.react(state);
    }
  }

  /// Увеличить загрязнение
  _pollute() {
    state.pollution += 0.1;
  }
}
