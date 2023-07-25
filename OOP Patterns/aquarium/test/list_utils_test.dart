import 'package:aquarium/utils/list_utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  /// Тесты для проверки расширения над списком,
  /// которое возвращает случайный элемент.
  group('RandomItem Extension test', () {
    /// Случай пустого списка
    test('no element', () {
      final list = [];
      final randomItem = list.getRandom();

      expect(randomItem, null);
    });

    /// Работа с одним элементом
    test('one element', () {
      const onlyOneItem = 'item1';
      final list = [onlyOneItem];
      final randomItem = list.getRandom();

      expect(randomItem, onlyOneItem);
    });

    /// Работа с двумя элементами
    test('two elements', () {
      const item1 = 'item1';
      const item2 = 'item2';
      final list = [item1, item2];
      final randomItem = list.getRandom();

      expect(randomItem, predicate((item) => item == item1 || item == item2));
    });

    /// Проверка того, что возвращенный элемент содержится в списке
    test('test contains element', () {
      final list = List.generate(10, (index) => index);
      final randomItem = list.getRandom();

      expect(list, contains(randomItem));
    });
  });
}
