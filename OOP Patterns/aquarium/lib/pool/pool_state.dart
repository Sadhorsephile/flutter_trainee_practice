/// Состояние бассейна
class PoolState {
  /// Температура бассейна
  double temperature;

  /// Загрязнение бассейна
  /// Значение в диапозоне от [0; 1]
  double pollution;

  PoolState({
    required this.temperature,
    required this.pollution,
  });
}

/// Нормальная температура для жизни рыб
const normalTemperature = 20.0;
