import 'package:aquarium/res/colors.dart';
import 'package:aquarium/res/strings.dart';
import 'package:aquarium/res/styles.dart';
import 'package:aquarium/ui/pool_screen/pool_wm.dart';
import 'package:aquarium/ui/pool_screen/widgets/fish_widget.dart';
import 'package:aquarium/ui/pool_screen/widgets/pollution_widget.dart';
import 'package:aquarium/ui/pool_screen/widgets/thermo_widget.dart';
import 'package:aquarium/ui/pool_screen/widgets/user_log_widget.dart';
import 'package:aquarium/utils/orientation_widget.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';

/// Экран бассейна
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
      body: OrientationSwitcher(
        children: [
          Flexible(
            flex: wm.poolFlex,
            child: Stack(
              children: [
                Container(
                  color: AppColors.waterColor,
                ),
                PoolPollutionLayerWidget(
                  pollution: wm.poolPollution,
                ),
                PoolThermometerWidget(
                  temperature: wm.poolTemperature,
                ),
                for (final fish in wm.fishes)
                  FishWidget(
                    fish: fish,
                    poolSize: wm.poolSize,
                    fishSize: wm.fishSize,
                  ),
              ],
            ),
          ),
          Flexible(
            flex: wm.logFlex,
            child: EntityStateNotifierBuilder<List<String>>(
              listenableEntityState: wm.logListState,
              builder: (context, list) {
                return UserLogWidget(
                  logList: list ?? [],
                  controller: wm.scrollController,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
