import 'dart:async';

import 'package:aquarium/fish/fish.dart';
import 'package:aquarium/pool/observable.dart';
import 'package:aquarium/pool/pool_state.dart';

/// Класс бассейна для рыб
class Pool implements AquariumObservable<Fish> {
  /// Список рыб, находящихся в бассейне
  /// Они являются обозревателями
  late final List<Fish> fishes;

  /// Текущее состояние бассейна
  /// НЕ менять свойства вручную - иначе рыбы не будут уведомлены
  PoolState _state;

  /// Текущее состояние бассейна
  /// НЕ менять свойства вручную - иначе рыбы не будут уведомлены
  PoolState get state => _state;

  /// Текущее состояние бассейна
  /// НЕ менять свойства вручную - иначе рыбы не будут уведомлены
  set state(PoolState value) {
    _state = value;
    notifyObservers();
  }

  /// Вместимость бассейна
  final int capacity;

  /// Время, после которого бассейн получает некоторую долю загрязнения
  static const pollutionDuration = Duration(seconds: 1);

  /// Время, после которого бассейн получает некоторую долю загрязнения
  static const pollutionIncreasing = 0.1;

  Pool({
    required PoolState state,
    required this.capacity,
  }) : _state = state {
    fishes = [];

    /// Автоматическое загрязнение
    Timer.periodic(pollutionDuration, (Timer t) {
      pollute();
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
  void pollute() {
    state = state.copyWith(pollution: state.pollution + pollutionIncreasing);
  }

  /// Изменить значение температуры
  void changeTemperature(double newTemperature) {
    state = state.copyWith(temperature: newTemperature);
  }

  /// Изменить значение загрязнения
  void changePollution(double newPollution) {
    state = state.copyWith(pollution: newPollution);
  }
}
