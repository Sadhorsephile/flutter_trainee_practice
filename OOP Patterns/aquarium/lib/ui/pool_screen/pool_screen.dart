import 'dart:async';
import 'dart:math';

import 'package:aquarium/fish/fish.dart';
import 'package:aquarium/res/colors.dart';
import 'package:aquarium/res/strings.dart';
import 'package:aquarium/pool/pool.dart';
import 'package:aquarium/res/styles.dart';
import 'package:aquarium/ui/pool_screen/pool_wm.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

///
class PoolScreen extends ElementaryWidget<IPoolWidgetModel> {
  const PoolScreen({
    Key? key,
    WidgetModelFactory wmFactory = defaultAppWidgetModelFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(IPoolWidgetModel wm) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      appBar: AppBar(
        title: const Text(
          AppStrings.aquarium,
          style: AppStyles.appbarTextStyle,
        ),
        backgroundColor: AppColors.appbarColor,
      ),
      body: Column(
        children: [
          Flexible(
            flex: 3,
            child: Stack(
              children: [
                Container(
                  color: AppColors.waterColor,
                ),
                PoolPollutionLayerWidget(
                  pollution: wm.context.watch<Pool>().state.pollution,
                ),
                PoolThermometerWidget(
                  temperature: wm.context.watch<Pool>().state.temperature,
                ),
                for (final fish in wm.context.watch<Pool>().fishes)
                  // TODO: Виджет для рыбы
                  // TODO: всплытие рыбы
                  FishWidget(fish: fish),
              ],
            ),
          ),
          // Экран с логами
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: ListView.builder(
                itemCount: 20,
                itemBuilder: (_, __) {
                  return Text(
                    'log : logloglog',
                    style: AppStyles.userLogStyle,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Виджет, отображаюший рыбу
class FishWidget extends StatefulWidget {
  const FishWidget({
    required this.fish,
    super.key,
  });

  final Fish fish;

  @override
  State<FishWidget> createState() => _FishWidgetState();
}

class _FishWidgetState extends State<FishWidget> {
  Fish get fish => widget.fish;

  double? left;
  double? top;
  double? right;
  double? bottom;

  @override
  void initState() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (widget.fish.state == FishState.dead) {
        setState(() {
          top = 0;
        });
        timer.cancel();
      }

      top = Random().nextInt(100).toDouble() + 50;
      left = Random().nextInt(100).toDouble() + 50;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      key: ValueKey<Fish>(fish),
      top: fish.state != FishState.dead
          ? Random().nextInt(100).toDouble() + 50
          : 0,
      left: fish.state != FishState.dead
          ? Random().nextInt(100).toDouble() + 50
          : null,
      child: Container(
        height: 100,
        width: 100,
        child: Image(image: AssetImage(fish.appearance.asset)),
      ),
      duration: Duration(seconds: 5),
    );
  }
}

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
