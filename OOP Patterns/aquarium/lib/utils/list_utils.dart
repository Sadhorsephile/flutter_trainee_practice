import 'dart:math';

/// Расширение для получения случайных элементов списка
extension RandomItem<T> on List<T> {
  /// Получить случайный элемент списка
  /// Или null если список пустой
  T? getRandom() {
    final random = Random();
    if (length == 0) {
      return null;
    }
    final index = random.nextInt(length);
    return this[index];
  }
}
