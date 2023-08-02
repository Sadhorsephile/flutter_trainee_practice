import 'package:flutter/material.dart';
import 'package:mvp_example/weather_presenter.dart';

/// Представление данных для пользователя
class WeatherView extends StatefulWidget {
  /// События представления могут повлиять только на презентор
  final WeatherPresenter presenter;

  const WeatherView({required this.presenter, super.key});

  @override
  State<WeatherView> createState() => WeatherViewState();
}

class WeatherViewState extends State<WeatherView> {
  /// Определяем интерфейс взамодействия с View

  int _currentCity = 0;

  int get currentCity => _currentCity;

  set currentCity(int value) {
    setState(() {
      _currentCity = value;
    });
  }

  double? _currentCityTemp;

  double? get currentCityTemp => _currentCityTemp;

  set currentCityTemp(double? value) {
    setState(() {
      _currentCityTemp = value;
    });
  }

  String? _error;

  String? get error => _error;

  set error(String? value) {
    setState(() {
      _error = value;
    });
  }

  bool? _isLoading;

  bool? get isLoading => _isLoading;

  set isLoading(bool? value) {
    setState(() {
      _isLoading = value;
    });
  }

  WeatherPresenter get presenter => widget.presenter;

  /// Передаем ссылку на интерфейс View при инициализации
  @override
  void initState() {
    presenter.init(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MVP'),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Row(
                children: [
                  Radio<int>(
                    value: 1,
                    groupValue: currentCity,

                    /// Пользователь вызывает методы у презентора
                    onChanged: (value) => presenter.onChanged(value),
                  ),
                  const Text('Воронеж'),
                ],
              ),
              Row(
                children: [
                  Radio(
                    value: 2,
                    groupValue: currentCity,
                    onChanged: (value) => presenter.onChanged(value),
                  ),
                  const Text('Елец'),
                ],
              ),
              Row(
                children: [
                  Radio(
                    value: 3,
                    groupValue: currentCity,
                    onChanged: (value) => presenter.onChanged(value),
                  ),
                  const Text('Москва'),
                ],
              ),
              Row(
                children: [
                  Radio(
                    value: 4,
                    groupValue: currentCity,
                    onChanged: (value) => presenter.onChanged(value),
                  ),
                  const Text('Краснодар'),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              Builder(
                builder: (context) {
                  if (isLoading == true) {
                    return const CircularProgressIndicator();
                  }

                  if (currentCityTemp != null) {
                    return Column(
                      children: [
                        Text('Температура: $currentCityTemp C'),
                        const SizedBox(
                          height: 10,
                        ),
                        if (currentCityTemp != null)
                          Stack(
                            children: [
                              Container(
                                height: 4,
                                width: 200,
                                color: Colors.grey,
                              ),
                              Container(
                                height: 4,
                                width: currentCityTemp! * 5,
                                color: Colors.red,
                              ),
                            ],
                          ),
                      ],
                    );
                  }
                  return SizedBox.shrink();
                },
              ),
              if (error != null)
                Text(
                  error!,
                  style: const TextStyle(color: Colors.red),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class ErrorWidget extends StatelessWidget {
  const ErrorWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Произошла ошибка',
      style: TextStyle(color: Colors.red),
    );
  }
}
