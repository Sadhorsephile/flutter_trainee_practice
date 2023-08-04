import 'package:aquarium/res/colors.dart';
import 'package:aquarium/res/strings.dart';
import 'package:flutter/material.dart';

/// Виджет для отображения температуры
class PoolThermometerWidget extends StatelessWidget {
  final double temperature;
  const PoolThermometerWidget({
    required this.temperature,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 8,
      top: 8,
      child: SizedBox(
        height: 120,
        child: DecoratedBox(
          decoration: const BoxDecoration(
            color: AppColors.thermoBackgroundColor,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: Column(
              children: [
                Text(temperature.toStringAsFixed(1)),
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    const SizedBox(
                      height: 80,
                      width: 5,
                      child: ColoredBox(
                        color: AppColors.thermoScaleColor,
                      ),
                    ),
                    AnimatedContainer(
                      height: temperature * 2,
                      width: 5,
                      color: AppColors.thermoColor,
                      duration: const Duration(seconds: 3),
                    ),
                  ],
                ),
                const Text(AppStrings.celsiusDegree),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
