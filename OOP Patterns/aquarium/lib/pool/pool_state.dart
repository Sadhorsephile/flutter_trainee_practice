import 'package:flutter/cupertino.dart';

/// Состояние бассейна
@immutable
class PoolState {
  /// Температура бассейна
  final double temperature;

  /// Загрязнение бассейна
  /// Значение в диапозоне от [0; 1]
  final double pollution;

  PoolState({
    required this.temperature,
    required this.pollution,
  });

  PoolState copyWith({double? temperature, double? pollution}) => PoolState(
        temperature: temperature ?? this.temperature,
        pollution: pollution ?? this.pollution,
      );
}

/// Нормальная температура для жизни рыб
const normalTemperature = 20.0;
