import 'package:flutter/material.dart';

/// Виджет, который переключает строку на столбец
/// в зависимости от ориентации устройства
class OrientationSwitcher extends StatelessWidget {
  final List<Widget> children;

  const OrientationSwitcher({
    required this.children,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    return orientation == Orientation.portrait
        ? Column(children: children)
        : Row(children: children);
  }
}
