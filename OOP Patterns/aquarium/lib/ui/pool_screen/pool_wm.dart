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

  /// Размер бассейна
  Size get poolSize;

  /// Размер рыбы
  Size get fishSize;

  /// flex для бассейна
  int get poolFlex;

  /// flex для логов
  int get logFlex;
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
  int get logFlex => 1;

  @override
  int get poolFlex => 3;

  MediaQueryData get media => MediaQuery.of(context);

  @override
  Size get fishSize => const Size(100, 100);

  double get poolHeight =>
      media.size.height *
          (media.orientation == Orientation.portrait
              ? poolFlex / (poolFlex + logFlex)
              : 1) -
      fishSize.height -
      200;

  double get poolWidth =>
      media.size.width *
          (media.orientation == Orientation.landscape
              ? poolFlex / (poolFlex + logFlex)
              : 1) -
      fishSize.width;

  @override
  Size get poolSize => Size(poolWidth, poolHeight);

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
