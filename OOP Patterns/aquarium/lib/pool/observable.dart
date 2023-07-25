import 'package:aquarium/pool/pool_state.dart';

/// Обозреватель
abstract class AquariumObserver {
  /// Реакция на новое состояние
  void react(PoolState newState);
}
