import 'dart:async';
import 'dart:math';

import 'package:aquarium/fish/fish.dart';
import 'package:flutter/material.dart';

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

class _FishWidgetState extends State<FishWidget>
    with SingleTickerProviderStateMixin {
  Fish get fish => widget.fish;
  late final Timer timer;

  double? prevTop;
  double? prevLeft;
  double top = 0;
  double left = Random().nextInt(300).toDouble() + 10;

  static Duration get moveSpeed => const Duration(seconds: 2);

  // TODO(AndrewVorotyntsev): grow up - scale
  // TODO(AndrewVorotyntsev): sick - blend

  /// Направление движения рыбы
  ///  1 - влево
  /// -1 - вправо
  double? get direction => prevLeft != null ? (prevLeft! - left).sign : 1;

  @override
  void initState() {
    timer = Timer.periodic(moveSpeed, (timer) {
      prevTop = top;
      prevLeft = left;
      if (widget.fish.state == FishState.dead) {
        top = -50;
        return;
      }

      top = Random().nextInt(300).toDouble() + 10;
      left = Random().nextInt(300).toDouble() + 10;
    });
    top = Random().nextInt(300).toDouble() + 10;
    left = Random().nextInt(300).toDouble() + 10;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      /// Связываем сущность рыбы с её виджетом
      key: ValueKey<Fish>(fish),
      top: top,
      left: left,
      duration: moveSpeed,
      child: AnimatedContainer(
        height: 100,
        width: 100,
        transform: Matrix4.rotationZ(
          (fish.state != FishState.dead ? 0 : 180 * 2 * pi) / 360,
        ),
        transformAlignment: Alignment.center,
        duration: moveSpeed,
        child: Transform.scale(
          // Направление движения рыбы (лево, право)
          scaleX: direction,
          child: Image(
            image: AssetImage(fish.appearance.asset),
          ),
        ),
      ),
    );
  }
}
