import 'package:aquarium/fish/fish.dart';
import 'package:aquarium/logger/description_stream_logger.dart';
import 'package:aquarium/pool/pool.dart';
import 'package:aquarium/ui/pool_screen/pool_model.dart';
import 'package:aquarium/ui/pool_screen/pool_screen.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Абстракция Widget Model для экрана бассейна
abstract class IPoolWidgetModel extends IWidgetModel {
  BuildContext get context;

  /// Скролл контроллер для логов
  ScrollController get scrollController;

  /// Состояние списка логов.
  ListenableState<EntityState<List<String>>> get logListState;

  /// Список рыб в бассейне
  List<Fish> get fishes;

  /// Температура бассейна
  double get poolTemperature;

  /// Загрязнение бассейна
  double get poolPollution;
}

PoolWidgetModel defaultAppWidgetModelFactory(BuildContext context) =>
    PoolWidgetModel(PoolScreenModel());

/// Имплементация и реализация Виджет модели
class PoolWidgetModel extends WidgetModel<PoolScreen, PoolScreenModel>
    implements IPoolWidgetModel {
  Pool get pool => context.watch<Pool>();

  @override
  List<Fish> get fishes => pool.fishes;

  @override
  double get poolPollution => pool.state.pollution;

  @override
  double get poolTemperature => pool.state.temperature;

  @override
  final EntityStateNotifier<List<String>> logListState =
      EntityStateNotifier<List<String>>();

  @override
  ScrollController scrollController = ScrollController();

  PoolWidgetModel(super._model);

  @override
  void initWidgetModel() {
    context.watch<DescriptionStreamLogger>().logStream.stream.listen((event) {
      /// Добавить новую запись к списку старых логов
      final previousData = logListState.value?.data ?? [];
      logListState.content([
        ...previousData,
        event,
      ]);

      /// Автоматически скролим в конец логов
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 200),
        curve: Curves.linear,
      );
    });
    super.initWidgetModel();
  }
}
