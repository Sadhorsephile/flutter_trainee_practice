import 'package:elementary/elementary.dart';

/// Модель содержит бизнес логику работы с данными
class WeatherModel extends ElementaryModel {
  WeatherModel() : super();

  //bool isError = true;
  bool isError = false;

  /// Данные о погоде
  final List<double> _weatherData = [22, 20, 18, 28];

  /// Получить данные (погоду для конкретного города)
  double getWeather(int? cityId) {
    /// Отвечает на запросы, меняя свое состояние
    if (cityId == null) {
      throw Exception('Произошла ошибка: cityId = null');
    }
    if (isError) {
      throw Exception('Произошла ошибка: isError');
    }
    switch (cityId) {
      case 1:
        return _weatherData[0];
      case 2:
        return _weatherData[1];
      case 3:
        return _weatherData[2];
      case 4:
        throw Exception('Произошла ошибка: case 4');
      default:
        throw Exception('Нет данных о погоде');
    }
  }
}
