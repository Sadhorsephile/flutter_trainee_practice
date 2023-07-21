import 'package:aquarium/pool/pool_state.dart';

/// Обозреваемая сущность
abstract class AquariumObservable<T extends AquariumObserver> {
  /// Добавить обозревателя
  void addObserver(T observer);

  /// Убрать обозревателя
  void removeObserver(T observer);

  /// Уведомить обозреватлей
  void notifyObservers();
}

/// Обозреватель
abstract class AquariumObserver {
  /// Реакция на новое состояние
  void react(PoolState newState);
}
