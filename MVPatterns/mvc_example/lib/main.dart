import 'package:flutter/material.dart';
import 'package:mvc_example/weather_controller.dart';
import 'package:mvc_example/weather_model.dart';
import 'package:mvc_example/weather_view.dart';

void main() {
  final model = WeatherModel(initialCitiId: 1);
  final controller = WeatherController(model: model);

  runApp(
    MyApp(
      controller: controller,
      model: model,
    ),
  );
}

class MyApp extends StatelessWidget {
  final WeatherController controller;
  final WeatherModel model;

  const MyApp({
    required this.controller,
    required this.model,
    super.key,
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WeatherView(
        controller: controller,
        model: model,
      ),
    );
  }
}
