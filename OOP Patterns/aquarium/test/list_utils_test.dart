import 'package:aquarium/utils/list_utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('RandomItem Extension test', () {
    test('no element', () {
      final list = [];
      final randomItem = list.getRandom();

      expect(randomItem, null);
    });

    test('one element', () {
      const onlyOneItem = 'item1';
      final list = [];
      list.add(onlyOneItem);
      final randomItem = list.getRandom();

      expect(randomItem, onlyOneItem);
    });

    test('two elements', () {
      const item1 = 'item1';
      const item2 = 'item2';
      final list = [item1, item2];
      final randomItem = list.getRandom();

      expect(randomItem, predicate((item) => item == item1 || item == item2));
    });

    test('test contains element', () {
      final list = List.generate(10, (index) => index);
      final randomItem = list.getRandom();

      expect(list, contains(randomItem));
    });
  });
}
