import 'package:aquarium/pool/pool.dart';
import 'package:aquarium/res/colors.dart';
import 'package:flutter/material.dart';

/// Отображение загрязнения
/// Представляет собой полупрозрачный цветной бокс
class PoolPollutionLayerWidget extends StatelessWidget {
  final double pollution;

  const PoolPollutionLayerWidget({
    required this.pollution,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: pollution < 1 ? pollution : 1,
      duration: Pool.pollutionDuration,
      child: Container(
        color: AppColors.pollutionColor,
      ),
    );
  }
}
