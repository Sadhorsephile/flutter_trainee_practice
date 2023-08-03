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

  // scale
  // sick - blend
  // remove delay create

  @override
  void initState() {
    timer = Timer.periodic(Duration(seconds: 2), (timer) {
      if (widget.fish.state == FishState.dead) {
        top = 0;
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
      key: ValueKey<Fish>(fish),
      top: top,
      left: left,
      // top: fish.state != FishState.dead
      //     ? Random().nextInt(100).toDouble() + 50
      //     : 0,
      // left: fish.state != FishState.dead
      //     ? Random().nextInt(100).toDouble() + 50
      //     : null,
      duration: Duration(seconds: 2),
      child: AnimatedContainer(
        height: 100,
        width: 100,
        transform: Matrix4.rotationZ(
            (fish.state != FishState.dead ? 0 : 180 * 2 * pi) / 360),
        transformAlignment: Alignment.center,
        duration: Duration(seconds: 2),
        child: Image(image: AssetImage(fish.appearance.asset)),
      ),
    );
  }
}
