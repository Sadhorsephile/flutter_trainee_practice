import 'package:aquarium/logger/description_stream_logger.dart';
import 'package:aquarium/ui/pool_screen/pool_model.dart';
import 'package:aquarium/ui/pool_screen/pool_screen.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Абстракция Widget Model
abstract class IPoolWidgetModel extends IWidgetModel {
  BuildContext get context;

  /// Скролл контроллер для логов
  ScrollController get scrollController;

  /// Состояние списка логов.
  ListenableState<EntityState<List<String>>> get logListState;
}

PoolWidgetModel defaultAppWidgetModelFactory(BuildContext context) {
  return PoolWidgetModel(
    PoolScreenModel(),
  );
}

/// Имплементация и реализация Виджет модели
class PoolWidgetModel extends WidgetModel<PoolScreen, PoolScreenModel>
    implements IPoolWidgetModel {
  @override
  final EntityStateNotifier<List<String>> logListState =
      EntityStateNotifier<List<String>>();

  @override
  ScrollController scrollController = ScrollController();

  PoolWidgetModel(PoolScreenModel model) : super(model);

  @override
  void initWidgetModel() {
    context.watch<DescriptionStreamLogger>().logStream.stream.listen((event) {
      /// Добавить новые лог к списку старых
      final previousData = logListState.value?.data ?? [];
      logListState.content([
        ...previousData,
        event,
      ]);

      /// Автоматически скролим в конец логов
      scrollController.animateTo(scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 200), curve: Curves.easeOut);
    });
    super.initWidgetModel();
  }
}
