import 'dart:math';

/// Расширение для получения случайных элементов списка
extension RandomItem<T> on List<T> {
  /// Получить случайный элемент списка
  /// Или null если список пустой
  T? getRandomOrNull(Random random) {
    if (isEmpty) {
      return null;
    }
    final index = random.nextInt(length);
    return this[index];
  }

  /// Получить случайный элемент непустого списка
  T getRandomOnNonEmpty(Random random) {
    if (isEmpty) {
      throw Exception('Список не может быть пустым');
    }
    final index = random.nextInt(length);
    return this[index];
  }
}
