import 'package:aquarium/ui/pool_screen/pool_model.dart';
import 'package:aquarium/ui/pool_screen/pool_screen.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';

/// Абстракция Widget Model
abstract class IPoolWidgetModel extends IWidgetModel {
  BuildContext get context;
}

PoolWidgetModel defaultAppWidgetModelFactory(BuildContext context) {
  return PoolWidgetModel(
    PoolScreenModel(),
  );
}

/// Имплементация и реализация Виджет модели
class PoolWidgetModel extends WidgetModel<PoolScreen, PoolScreenModel>
    implements IPoolWidgetModel {
  PoolWidgetModel(PoolScreenModel model) : super(model);
}
