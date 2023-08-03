import 'dart:async';
import 'dart:math';

import 'package:aquarium/fish/fish.dart';
import 'package:aquarium/res/colors.dart';
import 'package:aquarium/res/strings.dart';
import 'package:aquarium/pool/pool.dart';
import 'package:aquarium/res/styles.dart';
import 'package:aquarium/ui/pool_screen/pool_wm.dart';
import 'package:aquarium/ui/pool_screen/widgets/fish_widget.dart';
import 'package:aquarium/ui/pool_screen/widgets/pollution_widget.dart';
import 'package:aquarium/ui/pool_screen/widgets/thermo_widget.dart';
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
