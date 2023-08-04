/// Некторое события (намерения, Intent) в системе
sealed class WeatherEvent {}

/// Конкретная реализация намерения - получить погоду
class GetWeatherEvent implements WeatherEvent {
  /// Намерения могут содержать в себе данные
  int? cityId;

  GetWeatherEvent(this.cityId);
}
