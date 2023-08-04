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

  /// Таймер, регулирующий движение рыбы
  late final Timer swimTimer;

  double? prevTop;
  double? prevLeft;
  double top = 0;
  double left = Random().nextInt(300).toDouble() + 10;

  /// Время за которое рыба перемещается от одной точки к другой
  static Duration get moveSpeed => const Duration(seconds: 2);

  /// Время первоначального погружения рыбы
  static Duration get divingSpeed => const Duration(milliseconds: 200);

  // TODO(AndrewVorotyntsev): grow up - scale
  // TODO(AndrewVorotyntsev): sick - blend

  /// Направление движения рыбы
  ///  1 - влево
  /// -1 - вправо
  double get direction => prevLeft != null ? (prevLeft! - left).sign : 1;

  @override
  void initState() {
    diving();

    /// Задаем анимацию плавания рыбы
    swimTimer = Timer.periodic(moveSpeed, (timer) {
      prevTop = top;
      prevLeft = left;
      if (widget.fish.state == FishState.dead) {
        top = -50;
        swimTimer.cancel();
        return;
      }
      top = Random().nextInt(300).toDouble() + 10;
      left = Random().nextInt(300).toDouble() + 10;
    });
    super.initState();
  }

  /// Первое погружение рыбы
  /// Сначала рыба движется вниз имитируя её ныряние в аквариум
  Future<void> diving() async {
    await Future.delayed(divingSpeed);
    top = Random().nextInt(300).toDouble() + 10;
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
          fish.state != FishState.dead ? 0 : pi,
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
