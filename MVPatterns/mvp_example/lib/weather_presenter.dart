import 'package:flutter/material.dart';
import 'package:mvp_example/weather_model.dart';

/// Связывает модель и отображение.
/// Один презентер связан с одной View
class WeatherPresenter {
  WeatherModel model;

  /// Готовит данные для отображения
  final currentCity = ValueNotifier<int>(0);

  final currentCityTemp = ValueNotifier<double?>(null);

  final error = ValueNotifier<String?>(null);

  final isLoading = ValueNotifier<bool?>(null);

  WeatherPresenter({required this.model}) {
    /// Установить отображаемый город
    currentCity.value = model.currentCitiId;
    onChanged(currentCity.value);
    // try {
    //   /// Вызывает методы у модели и получает от неё данные
    //   currentCityTemp.value = model.getWeather(currentCity.value);
    // } on Exception catch (_) {
    //   /// Также передает информацию об ошибках
    //   currentCityTemp.value = null;
    //   error.value = 'Произошла ошибка';
    // }
  }

  void dispose() {
    currentCity.dispose();
    currentCityTemp.dispose();
    error.dispose();
  }

  void onChanged(int? id) async {
    currentCity.value = id ?? currentCity.value;

    /// Очистить ошибку
    error.value = null;
    isLoading.value = true;
    // Имитация загрузки
    await Future<void>.delayed(Duration(seconds: 1));

    try {
      /// Запросить данные из модели и подготовить к отображению
      currentCityTemp.value = model.getWeather(id);
    } on Exception catch (_) {
      /// Подготовить к отображению ошибку
      currentCityTemp.value = null;
      error.value = 'Произошла ошибка';
    } finally {
      /// Сменить данные для текущего города

      isLoading.value = false;
    }
  }
}
