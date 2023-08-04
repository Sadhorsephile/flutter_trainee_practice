import 'dart:async';
import 'dart:math';

import 'package:aquarium/fish/fish.dart';
import 'package:flutter/material.dart';

/// Виджет, отображаюший рыбу
class FishWidget extends StatefulWidget {
  /// Размеры бассейна по которому рыба может плавать
  final Size poolSize;

  /// Размер рыбы
  final Size fishSize;

  const FishWidget({
    required this.fish,
    required this.poolSize,
    required this.fishSize,
    super.key,
  });

  final Fish fish;

  @override
  State<FishWidget> createState() => _FishWidgetState();
}

class _FishWidgetState extends State<FishWidget>
    with SingleTickerProviderStateMixin {
  final random = Random();
  Fish get fish => widget.fish;
  Size get poolSize => widget.poolSize;
  Size get fishSize => widget.fishSize;

  /// Таймер, регулирующий движение рыбы
  late final Timer swimTimer;

  /// Таймер, регулирующий рост рыбы
  late final Timer growTimer;

  double? prevTop;
  double? prevLeft;
  double top = 0;
  double left = 0;

  /// Время за которое рыба перемещается от одной точки к другой
  static Duration get moveSpeed => const Duration(seconds: 2);

  /// Время первоначального погружения рыбы
  static Duration get divingSpeed => const Duration(milliseconds: 200);

  /// Время роста рыбы
  static Duration get growTime => const Duration(seconds: 6);

  /// Направление движения рыбы
  ///  1 - влево
  /// -1 - вправо
  double get direction => prevLeft != null ? (prevLeft! - left).sign : 1;

  /// Изначальный размер рыбы
  double scale = 0.5;

  /// Прирост размера рыбы за время [growTime]
  static const scalePerTime = 0.25;

  @override
  void initState() {
    left = random.nextInt(poolSize.width.toInt()).toDouble();
    diving();

    /// Задаем анимацию плавания рыбы
    swimTimer = Timer.periodic(moveSpeed, (timer) {
      prevTop = top;
      prevLeft = left;
      if (widget.fish.state == FishState.dead) {
        top = -30;
        swimTimer.cancel();
        return;
      }
      top = random.nextInt(poolSize.height.toInt()).toDouble();
      left = random.nextInt(poolSize.width.toInt()).toDouble();
    });
    growTimer = Timer.periodic(growTime, (timer) {
      growUp();
    });
    super.initState();
  }

  /// Рост рыбы
  void growUp() {
    if (scale <= 1 && fish.state != FishState.dead) {
      scale += scalePerTime;
    } else {
      growTimer.cancel();
    }
  }

  /// Первое погружение рыбы
  /// Сначала рыба движется вниз имитируя её ныряние в аквариум
  Future<void> diving() async {
    await Future.delayed(divingSpeed);
    top = random.nextInt(poolSize.height.toInt()).toDouble();
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
        height: fishSize.height * scale,
        width: fishSize.width * scale,
        transform: Matrix4.rotationZ(
          fish.state != FishState.dead ? 0 : pi,
        ),
        transformAlignment: Alignment.center,
        duration: moveSpeed,
        child: Transform.scale(
          // Направление движения рыбы (лево, право)
          // Необходимо указать 1 для всплытия рыбы
          scaleX: fish.state != FishState.dead ? direction : 1,
          child: Image(
            /// Подсвечиваем зеленым цветом нездоровых рыб
            color: fish.state != FishState.healthy
                ? Colors.lightGreen.shade300
                : null,
            colorBlendMode: BlendMode.modulate,
            image: AssetImage(fish.appearance.asset),
          ),
        ),
      ),
    );
  }
}
