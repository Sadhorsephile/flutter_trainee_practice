import 'package:mvc_example/weather_model.dart';

/// Связывает модель и отображение.
class WeatherController {
  WeatherModel model;

  WeatherController({required this.model});

  void initController() => model.initModel();

  void dispose() => model.dispose();

  void onChanged(int? id) {
    /// Валидация пользовательских данных
    if (id != null) {
      /// Запросить данные из модели
      model.getWeather(id);
    }
  }
}
