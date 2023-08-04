import 'package:flutter/material.dart';
import 'package:mvc_example/weather_controller.dart';
import 'package:mvc_example/weather_model.dart';

/// Представление данных для пользователя
class WeatherView extends StatefulWidget {
  /// События представления могут повлиять только на контроллер
  final WeatherController controller;

  /// Модель поставляет данные для View
  final WeatherModel model;

  const WeatherView({
    required this.controller,
    required this.model,
    super.key,
  });

  @override
  State<WeatherView> createState() => _WeatherViewState();
}

class _WeatherViewState extends State<WeatherView> {
  WeatherController get controller => widget.controller;
  WeatherModel get model => widget.model;

  @override
  void initState() {
    controller.initController();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MVC'),
      ),
      body: SafeArea(
        child: ValueListenableBuilder(
          /// Модель передает данные для пользователя
          /// View их отображает
          valueListenable: model.currentCity,
          builder: (context, currentCity, child) {
            /// View их отображает
            /// Данные могут отображаться в нескольких местах
            return Center(
              child: Column(
                children: [
                  Row(
                    children: [
                      Radio<int>(
                        value: 1,
                        groupValue: currentCity,

                        /// Пользователь вызывает методы у контроллера
                        onChanged: (value) => controller.onChanged(value),
                      ),
                      const Text('Воронеж'),
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                        value: 2,
                        groupValue: currentCity,
                        onChanged: (value) => controller.onChanged(value),
                      ),
                      const Text('Елец'),
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                        value: 3,
                        groupValue: currentCity,
                        onChanged: (value) => controller.onChanged(value),
                      ),
                      const Text('Москва'),
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                        value: 4,
                        groupValue: currentCity,
                        onChanged: (value) => controller.onChanged(value),
                      ),
                      const Text('Краснодар'),
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  ValueListenableBuilder(
                    valueListenable: model.isLoading,
                    builder: (context, isLoading, child) {
                      if (isLoading == true) {
                        return const CircularProgressIndicator();
                      }

                      return Column(
                        children: [
                          ValueListenableBuilder(
                            valueListenable: model.currentCityTemp,
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
                            valueListenable: model.currentCityTemp,
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
                        ],
                      );
                    },
                  ),
                  ValueListenableBuilder(
                    valueListenable: model.error,
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
