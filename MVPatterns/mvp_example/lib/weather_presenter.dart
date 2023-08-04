import 'package:mvp_example/weather_model.dart';
import 'package:mvp_example/weather_view.dart';

/// Связывает модель и отображение.
/// Один презентер связан с одной View
class WeatherPresenter {
  /// Презентер отправляет запросы к модели
  final WeatherModel model;

  /// Презентер вызывает методы у View через его интерфейс
  late final IWeatherViewState view;

  WeatherPresenter({required this.model});

  void init(WeatherViewState widgetState) {
    view = widgetState;
    view.currentCity = model.currentCitiId;
    onChanged(view.currentCity);
  }

  void onChanged(int? id) async {
    view.currentCity = id ?? view.currentCity;

    /// Очистить ошибку
    view.error = null;
    view.isLoading = true;
    // Имитация загрузки
    await Future<void>.delayed(Duration(seconds: 1));

    try {
      /// Запросить данные из модели и подготовить к отображению
      view.currentCityTemp = model.getWeather(id);
    } on Exception catch (_) {
      /// Подготовить к отображению ошибку
      view.currentCityTemp = null;
      view.error = 'Произошла ошибка';
    } finally {
      /// Сменить данные для текущего города

      view.isLoading = false;
    }
  }
}
