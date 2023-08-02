import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mvi_example/weather_event.dart';
import 'package:mvi_example/weather_state.dart';

/// Модель получет намерения и отправляет обновленные состояния
class WeatherModel extends Bloc<WeatherEvent, WeatherState> {
  /// Служебная информация для демо
  bool isError = false;

  /// Данные о погоде
  final List<double> _weatherData = [22, 20, 18, 28];

  WeatherModel(super.initialState) {
    /// Маппинг намерений и обработчиков
    on<GetWeatherEvent>(_onGetWeather);
  }

  /// Обработать намерение о получении данных о погоде
  void _onGetWeather(GetWeatherEvent event, Emitter<WeatherState> emit) async {
    emit(LoadingState());
    await Future<void>.delayed(Duration(seconds: 1));
    var currentCity = event.cityId;
    if (isError) {
      emit(ErrorState(error: 'Произошла ошибка: isError', cityId: currentCity));
      return;
    }
    if (currentCity == null) {
      emit(ErrorState(error: 'Произошла ошибка: cityId = null', cityId: null));
      return;
    }
    switch (currentCity) {
      case 1:
        emit(
          NewWeatherDataState(
            cityId: currentCity,
            temperature: _weatherData[0],
          ),
        );
        return;
      case 2:
        emit(
          NewWeatherDataState(
            cityId: currentCity,
            temperature: _weatherData[1],
          ),
        );
        return;
      case 3:
        emit(
          NewWeatherDataState(
            cityId: currentCity,
            temperature: _weatherData[2],
          ),
        );
        return;
      case 4:
        emit(
            ErrorState(error: 'Произошла ошибка: case 4', cityId: currentCity));
        return;
      default:
        emit(ErrorState(
            error: 'Произошла ошибка: Нет данных о погоде',
            cityId: currentCity));
        return;
    }
  }
}
