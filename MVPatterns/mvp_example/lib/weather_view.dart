import 'package:flutter/material.dart';
import 'package:mvp_example/weather_presenter.dart';

/// Представление данных для пользователя
class WeatherView extends StatefulWidget {
  /// События представления могут повлиять только на презентор
  final WeatherPresenter presenter;

  const WeatherView({required this.presenter, super.key});

  @override
  State<WeatherView> createState() => _WeatherViewState();
}

class _WeatherViewState extends State<WeatherView> {
  WeatherPresenter get presenter => widget.presenter;

  @override
  void dispose() {
    presenter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MVP'),
      ),
      body: SafeArea(
        child: ValueListenableBuilder(
          /// Презентор передает данные для пользователя
          /// View их отображает
          valueListenable: presenter.currentCity,
          builder: (context, currentCity, child) {
            /// View их отображает
            return Center(
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
                  ValueListenableBuilder(
                    valueListenable: presenter.currentCityTemp,
                    builder: (context, temperature, child) {
                      if (temperature != null) {
                        return Text('Температура: $temperature C');
                      }

                      return const SizedBox.shrink();
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ValueListenableBuilder(
                    valueListenable: presenter.currentCityTemp,
                    builder: (context, temperature, child) {
                      if (temperature != null) {
                        return Stack(
                          children: [
                            Container(
                              height: 4,
                              width: 200,
                              color: Colors.grey,
                            ),
                            Container(
                              height: 4,
                              width: temperature * 5,
                              color: Colors.red,
                            ),
                          ],
                        );
                      }

                      return const SizedBox.shrink();
                    },
                  ),
                  ValueListenableBuilder(
                    valueListenable: presenter.error,
                    builder: (context, error, child) {
                      if (error != null) {
                        return Text(
                          error,
                          style: const TextStyle(color: Colors.red),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ],
              ),
            );
          },
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
