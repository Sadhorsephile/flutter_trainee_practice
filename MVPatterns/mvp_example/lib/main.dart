import 'package:flutter/material.dart';
import 'package:mvp_example/weather_presenter.dart';
import 'package:mvp_example/weather_model.dart';
import 'package:mvp_example/weather_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WeatherView(
        presenter: WeatherPresenter(
          model: WeatherModel(initialCitiId: 1),
        ),
      ),
    );
  }
}
