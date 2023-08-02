import 'package:flutter/foundation.dart';

/// Модель представляет собой данные и методы для работы с ними
/// Модель никак не зависит от других слоев
class WeatherModel {
  int initialCitiId;

  /// Данные для отображения
  final currentCity = ValueNotifier<int>(0);

  final currentCityTemp = ValueNotifier<double?>(null);

  final error = ValueNotifier<String?>(null);

  final isLoading = ValueNotifier<bool?>(null);

  /// Присутствует ли ошибка (для демо)
  //bool isError = true;
  bool isError = false;

  WeatherModel({required this.initialCitiId});

  void initModel() async {
    isLoading.value = true;
    await Future<void>.delayed(Duration(seconds: 1));
    currentCity.value = initialCitiId;
    getWeather(initialCitiId);
    isLoading.value = false;
    error.addListener(() {
      currentCityTemp.value = null;
    });
  }

  void dispose() {
    currentCity.dispose();
    currentCityTemp.dispose();
    error.dispose();
  }

  /// Данные о погоде
  final List<double> _weatherData = [22, 20, 18, 28];

  /// Получить данные (погоду для конкретного города)
  void getWeather(int cityId) async {
    error.value = null;
    isLoading.value = true;
    await Future<void>.delayed(Duration(seconds: 1));

    /// Отвечает на запросы, меняя свое состояние
    currentCity.value = cityId;
    if (isError) {
      error.value = 'Произошла ошибка: isError';
      return;
    }
    switch (cityId) {
      case 1:
        currentCityTemp.value = _weatherData[0];
      case 2:
        currentCityTemp.value = _weatherData[1];
      case 3:
        currentCityTemp.value = _weatherData[2];
      case 4:
        error.value = 'Произошла ошибка: case 4';
      default:
        error.value = 'Нет данных о погоде';
    }
    isLoading.value = false;
  }
}
