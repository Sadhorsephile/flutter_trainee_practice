import 'package:aquarium/res/colors.dart';
import 'package:flutter/material.dart';

class PoolPollutionLayerWidget extends StatelessWidget {
  final double pollution;

  const PoolPollutionLayerWidget({
    super.key,
    required this.pollution,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: pollution < 1 ? pollution : 1,
      duration: Duration(seconds: 1),
      child: Container(
        color: AppColors.pollutionColor,
      ),
    );
  }
}
