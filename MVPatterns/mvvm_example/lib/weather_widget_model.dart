import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:mvvm_example/weather_model.dart';
import 'package:mvvm_example/weather_view.dart';

/// Виджет модель
/// Является абстракцией над моделью
/// Содержит презентационную логику
/// Один экземпляр View-модели связан с одним отображением
abstract class IWeatherWidgetModel extends IWidgetModel {
  /// Состояние текущего города
  ListenableState<EntityState<int?>> get currentCityIdState;

  /// Состояние данных о погоде
  ListenableState<EntityState<double>> get temperatureState;

  /// Состояние ошибки
  ListenableState<EntityState<String?>> get errorState;

  /// Действия по изменению города
  void onCityChange(int? cityId);
}

WeatherViewWidgetModel defaultAppWidgetModelFactory(BuildContext context) {
  return WeatherViewWidgetModel(
    WeatherModel(),
  );
}

/// Имплементация и реализация Виджет модели [IHomeUserProfileWidgetModel]
class WeatherViewWidgetModel extends WidgetModel<WeatherView, WeatherModel>
    implements IWeatherWidgetModel {
  WeatherViewWidgetModel(WeatherModel model) : super(model);

  @override
  final EntityStateNotifier<String?> errorState =
      EntityStateNotifier<String?>();

  @override
  final EntityStateNotifier<double> temperatureState =
      EntityStateNotifier<double>();

  @override
  final EntityStateNotifier<int?> currentCityIdState =
      EntityStateNotifier<int?>();

  @override
  void initWidgetModel() {
    onCityChange(1);
    super.initWidgetModel();
  }

  @override
  void dispose() {
    errorState.dispose();
    temperatureState.dispose();
    currentCityIdState.dispose();
    super.dispose();
  }

  @override
  void onCityChange(int? cityId) async {
    try {
      errorState.content(null);
      currentCityIdState.content(cityId);
      temperatureState.loading();

      /// Имитация загрузки
      await Future<void>.delayed(Duration(seconds: 1));

      /// Вызываются методы у модели
      final newTemperature = model.getWeather(cityId);
      temperatureState.content(newTemperature);
    } catch (e) {
      temperatureState.error();
      errorState.content(e.toString());
    }
  }
}
