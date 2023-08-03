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

  double? top = 0;
  double? left = Random().nextInt(300).toDouble() + 10;

  static Duration get moveSpeed => const Duration(seconds: 2);

  // TODO(AndrewVorotyntsev): grow up - scale
  // TODO(AndrewVorotyntsev): sick - blend

  @override
  void initState() {
    timer = Timer.periodic(moveSpeed, (timer) {
      if (widget.fish.state == FishState.dead) {
        top = -50;
        return;
      }

      top = Random().nextInt(300).toDouble() + 10;
      left = Random().nextInt(300).toDouble() + 10;
    });
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
        child: Image(image: AssetImage(fish.appearance.asset)),
      ),
    );
  }
}
