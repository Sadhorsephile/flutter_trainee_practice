import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:mvvm_example/weather_widget_model.dart';

/// Пользовательксий интерфейс
class WeatherView extends ElementaryWidget<IWeatherWidgetModel> {
  const WeatherView({
    Key? key,
    WidgetModelFactory wmFactory = defaultAppWidgetModelFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(IWeatherWidgetModel wm) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MVVM'),
      ),
      body: SafeArea(
        child: EntityStateNotifierBuilder<int?>(
          listenableEntityState: wm.currentCityIdState,
          builder: (context, currentCity) {
            /// View их отображает
            return Center(
              child: Column(
                children: [
                  Row(
                    children: [
                      Radio<int>(
                        value: 1,
                        groupValue: currentCity,
                        onChanged: (value) => wm.onCityChange(value),
                      ),
                      const Text('Воронеж'),
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                        value: 2,
                        groupValue: currentCity,
                        onChanged: (value) => wm.onCityChange(value),
                      ),
                      const Text('Елец'),
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                        value: 3,
                        groupValue: currentCity,
                        onChanged: (value) => wm.onCityChange(value),
                      ),
                      const Text('Москва'),
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                        value: 4,
                        groupValue: currentCity,
                        onChanged: (value) => wm.onCityChange(value),
                      ),
                      const Text('Краснодар'),
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  EntityStateNotifierBuilder<double>(
                      listenableEntityState: wm.temperatureState,
                      loadingBuilder: (_, __) {
                        return CircularProgressIndicator();
                      },
                      builder: (context, temperature) {
                        if (temperature != null) {
                          return Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: Text('Температура: $temperature C'),
                              ),
                              Stack(
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
                              ),
                            ],
                          );
                        }

                        return const SizedBox.shrink();
                      }),
                  EntityStateNotifierBuilder<String?>(
                      listenableEntityState: wm.errorState,
                      builder: (context, error) {
                        if (error != null) {
                          return Text(
                            error,
                            style: const TextStyle(color: Colors.red),
                          );
                        }

                        return const SizedBox.shrink();
                      }),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
