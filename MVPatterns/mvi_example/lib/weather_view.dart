import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mvi_example/weather_event.dart';
import 'package:mvi_example/weather_model.dart';
import 'package:mvi_example/weather_state.dart';

/// Представление данных для пользователя
class WeatherView extends StatefulWidget {
  const WeatherView({super.key});

  @override
  State<WeatherView> createState() => _WeatherViewState();
}

class _WeatherViewState extends State<WeatherView> {
  @override
  void initState() {
    /// View отправляет некоторые намерения в модель
    context.read<WeatherModel>().add(GetWeatherEvent(1));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MVI'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            /// Отрисовка состояния системы
            BlocBuilder<WeatherModel, WeatherState>(
              builder: (context, state) {
                switch (state) {
                  case LoadingState():
                    return const Padding(
                      padding: EdgeInsets.only(top: 100),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  case ErrorState():
                    return Column(
                      children: [
                        CityGroupWidget(
                          state: state,
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        Text(
                          state.error,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ],
                    );
                  case NewWeatherDataState():
                    return Center(
                      child: Column(
                        children: [
                          CityGroupWidget(
                            state: state,
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          Text('Температура: ${state.temperature} C'),
                          const SizedBox(
                            height: 10,
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
                                width: state.temperature * 5,
                                color: Colors.red,
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                }
              },
            ),
            // BlocBuilder<WeatherModel, WeatherState>(
            //   builder: (context, state) {
            //     if (state is ErrorState) {
            //       return Text(
            //         state.error,
            //         style: const TextStyle(color: Colors.red),
            //       );
            //     }
            //
            //     return SizedBox.shrink();
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}

class CityGroupWidget extends StatelessWidget {
  final LoadedState state;

  const CityGroupWidget({
    required this.state,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Radio<int>(
              value: 1,
              groupValue: state.cityId,
              onChanged: (value) =>
                  context.read<WeatherModel>().add(GetWeatherEvent(value)),
            ),
            const Text('Воронеж'),
          ],
        ),
        Row(
          children: [
            Radio(
              value: 2,
              groupValue: state.cityId,
              onChanged: (value) =>
                  context.read<WeatherModel>().add(GetWeatherEvent(value)),
            ),
            const Text('Елец'),
          ],
        ),
        Row(
          children: [
            Radio(
              value: 3,
              groupValue: state.cityId,
              onChanged: (value) =>
                  context.read<WeatherModel>().add(GetWeatherEvent(value)),
            ),
            const Text('Москва'),
          ],
        ),
        Row(
          children: [
            Radio(
              value: 4,
              groupValue: state.cityId,
              onChanged: (value) =>
                  context.read<WeatherModel>().add(GetWeatherEvent(value)),
            ),
            const Text('Краснодар'),
          ],
        ),
      ],
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
