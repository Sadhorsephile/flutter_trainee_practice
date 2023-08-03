import 'package:aquarium/res/colors.dart';
import 'package:aquarium/res/strings.dart';
import 'package:flutter/material.dart';

/// Виджет для отображения температуры
class PoolThermometerWidget extends StatelessWidget {
  final double temperature;
  const PoolThermometerWidget({
    super.key,
    required this.temperature,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 8,
      top: 8,
      child: Container(
        height: 120,
        decoration: BoxDecoration(
            color: AppColors.thermoBackgroundColor,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Column(
            children: [
              Text('$temperature'),
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    height: 80,
                    width: 5,
                    color: AppColors.thermoScaleColor,
                  ),
                  AnimatedContainer(
                    height: temperature * 2,
                    width: 5,
                    color: AppColors.thermoColor,
                    duration: Duration(seconds: 1),
                  ),
                ],
              ),
              const Text(AppStrings.celsiusDegree),
            ],
          ),
        ),
      ),
    );
  }
}
