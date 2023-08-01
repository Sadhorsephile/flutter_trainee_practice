import 'dart:math';

import 'package:aquarium/utils/list_utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  /// Тесты для проверки расширения над списком,
  /// которое возвращает случайный элемент.
  group('getRandomOrNull test', () {
    /// Случай пустого списка
    test('no element', () {
      final list = [];
      final random = Random();
      final randomItem = list.getRandomOrNull(random);

      expect(randomItem, null);
    });

    /// Работа с одним элементом
    test('one element', () {
      const onlyOneItem = 'item1';
      final list = [onlyOneItem];
      final random = Random();
      final randomItem = list.getRandomOrNull(random);

      expect(randomItem, onlyOneItem);
    });

    /// Работа с двумя элементами
    test('two elements', () {
      const item1 = 'item1';
      const item2 = 'item2';
      final list = [item1, item2];
      final random = Random();
      final randomItem = list.getRandomOrNull(random);

      expect(randomItem, predicate((item) => item == item1 || item == item2));
    });

    /// Проверка того, что возвращенный элемент содержится в списке
    test('test contains element', () {
      final list = List.generate(10, (index) => index);
      final random = Random();
      final randomItem = list.getRandomOrNull(random);

      expect(list, contains(randomItem));
    });
  });

  group('getRandomOnNonEmpty test', () {
    /// Случай пустого списка
    test('no element', () {
      final list = [];
      final random = Random();
      try {
        list.getRandomOnNonEmpty(random);
      } on Exception catch (e) {
        expect(e, isA<Exception>());
      }
    });

    /// Работа с одним элементом
    test('one element', () {
      const onlyOneItem = 'item1';
      final list = [onlyOneItem];
      final random = Random();
      final randomItem = list.getRandomOnNonEmpty(random);

      expect(randomItem, onlyOneItem);
    });

    /// Работа с двумя элементами
    test('two elements', () {
      const item1 = 'item1';
      const item2 = 'item2';
      final list = [item1, item2];
      final random = Random();
      final randomItem = list.getRandomOnNonEmpty(random);

      expect(randomItem, predicate((item) => item == item1 || item == item2));
    });

    /// Проверка того, что возвращенный элемент содержится в списке
    test('test contains element', () {
      final list = List.generate(10, (index) => index);
      final random = Random();
      final randomItem = list.getRandomOnNonEmpty(random);

      expect(list, contains(randomItem));
    });
  });
}
