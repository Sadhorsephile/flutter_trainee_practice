import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mvi_example/weather_event.dart';
import 'package:mvi_example/weather_model.dart';
import 'package:mvi_example/weather_state.dart';
import 'package:mvi_example/weather_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',

      /// Инъекция зависимости (модели)
      home: BlocProvider<WeatherModel>(
        create: (_) => WeatherModel(LoadingState()),
        child: const WeatherView(),
      ),
    );
  }
}
