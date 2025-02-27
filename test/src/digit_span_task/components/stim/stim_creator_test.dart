import 'package:digit_span_tasks/src/digit_span_task/components/stim/stim_creator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('createDigitSet', () {
    test('given size = 2, return a string of 2 digits', () {
      final String digits = createDigitSet(size: 2);

      expect(digits.length, 2);
    });

    test(
      "given size = 0, throw an exception",
      () {
        expect(() => createDigitSet(size: 0), throwsArgumentError);
      },
    );
  });

  group(
    "createDigitSetOfSize",
    () {
      test(
        "given size = 2 and setCount = 1, return a list with 1 string of 2 digits",
        () {
          final List<String> digitSets =
              createDigitSetOfSize(size: 2, setCount: 1);
          expect(digitSets.length, 1);
          expect(digitSets.first.length, 2);
        },
      );
      test(
        "given size = 2 and setCount = 2, return a list of 2 strings, each of 2 digits",
        () {
          final List<String> digitSets =
              createDigitSetOfSize(size: 2, setCount: 2);
          expect(digitSets.length, 2);
          expect(digitSets.first.length, 2);
        },
      );
      test(
        "given size = 5 and setCount = 3, return a list of 3 strings, each of 5 digits",
        () {
          final List<String> digitSets =
              createDigitSetOfSize(size: 5, setCount: 3);
          expect(digitSets.length, 3);
          expect(digitSets.first.length, 5);
        },
      );
    },
  );
  group(
    "createDigitSets",
    () {
      test(
        "given minSize = 3, maxSize = 3, countEachSize = 1, return 1 set of 3 digits",
        () {
          final List<String> digitSets =
              createDigitSets(minSize: 3, maxSize: 3, countEachSize: 1);

          expect(digitSets.length, 1);
          expect(digitSets[0].length, 3);
        },
      );
      test(
        "given minSize = 2, maxSize = 4, countEachSize = 2, return 6 sets and 2 sets of each size (i.e., 2, 3, and 4)",
        () {
          final List<String> digitSets =
              createDigitSets(minSize: 2, maxSize: 4, countEachSize: 2);

          expect(digitSets.length, 6);
          expect(digitSets[0].length, 2);
          expect(digitSets[1].length, 2);
          expect(digitSets[2].length, 3);
          expect(digitSets[3].length, 3);
          expect(digitSets[4].length, 4);
          expect(digitSets[5].length, 4);
        },
      );
    },
  );
}
