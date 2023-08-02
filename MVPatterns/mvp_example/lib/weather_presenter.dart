import 'package:mvp_example/weather_model.dart';
import 'package:mvp_example/weather_view.dart';

/// Связывает модель и отображение.
/// Один презентер связан с одной View
class WeatherPresenter {
  /// Презентер отправляет запросы к модели
  final WeatherModel model;

  /// Презентер вызывает методы у View через его интерфейс
  late final WeatherViewState state;

  WeatherPresenter({required this.model});

  void init(WeatherViewState widgetState) {
    state = widgetState;
    state.currentCity = model.currentCitiId;
    onChanged(state.currentCity);
  }

  void onChanged(int? id) async {
    state.currentCity = id ?? state.currentCity;

    /// Очистить ошибку
    state.error = null;
    state.isLoading = true;
    // Имитация загрузки
    await Future<void>.delayed(Duration(seconds: 1));

    try {
      /// Запросить данные из модели и подготовить к отображению
      state.currentCityTemp = model.getWeather(id);
    } on Exception catch (_) {
      /// Подготовить к отображению ошибку
      state.currentCityTemp = null;
      state.error = 'Произошла ошибка';
    } finally {
      /// Сменить данные для текущего города

      state.isLoading = false;
    }
  }
}
