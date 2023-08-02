/// Модель представляет собой данные и методы для работы с ними
/// Модель никак не зависит от других слоев
class WeatherModel {
  int initialCitiId;

  /// Текущий город
  int currentCitiId;

  /// Присутствует ли ошибка (для демо)
  //bool isError = true;
  bool isError = false;

  WeatherModel({required this.initialCitiId}) : currentCitiId = initialCitiId;

  /// Данные о погоде
  final List<double> _weatherData = [22, 20, 18, 28];

  /// Получить данные (погоду для конкретного города)
  double getWeather(int? cityId) {
    /// Отвечает на запросы, меняя свое состояние
    if (cityId == null) {
      throw Exception('Произошла ошибка');
    }
    currentCitiId = cityId;
    if (isError) {
      throw Exception('Произошла ошибка');
    }
    switch (cityId) {
      case 1:
        return _weatherData[0];
      case 2:
        return _weatherData[1];
      case 3:
        return _weatherData[2];
      case 4:
        throw Exception('Произошла ошибка');
      default:
        throw Exception('Нет данных о погоде');
    }
  }
}
