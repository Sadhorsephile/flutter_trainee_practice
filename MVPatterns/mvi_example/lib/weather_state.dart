/// Некоторое состояние системы
sealed class WeatherState {}

/// Состояние загрузки
class LoadingState implements WeatherState {}

/// Загруженное состояние
sealed class LoadedState implements WeatherState {
  int? get cityId;
}

/// Состояния получения новых данных
class NewWeatherDataState implements LoadedState {
  @override
  int cityId;
  double temperature;

  NewWeatherDataState({
    required this.cityId,
    required this.temperature,
  });
}

/// Состояние ошибки
class ErrorState implements LoadedState {
  String error;
  @override
  int? cityId;

  ErrorState({
    required this.cityId,
    required this.error,
  });
}
