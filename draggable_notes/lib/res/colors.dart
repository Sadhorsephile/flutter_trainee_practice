import 'package:flutter/material.dart';

/// Палитра цветов для светлой темы
class AppColorsLight {
  static const canvasColor = Colors.white;
  static const mainColor = Colors.yellow;
  static Color cardColor = Colors.yellowAccent.shade200.withAlpha(100);
  static const buttonColor = Colors.orange;
  static Color errorColor = Colors.red;
  static Color radioColorSelected = Colors.blue;
  static Color radioColorUnselected = Colors.grey;
}

/// Палитра цветов для темной темы
class AppColorsDark {
  static const canvasColor = Color(0xFF202124);
  static Color dialogColor = Colors.grey;
  static const mainColor = Color(0xFF301E67);
  static Color cardColor = Colors.grey;
  static const buttonColor = Colors.indigo;
  static Color errorColor = Color(0xFFE96479);
  static Color radioColorSelected = Colors.blue.shade300;
  static Color radioColorUnselected = Colors.white60;
}
