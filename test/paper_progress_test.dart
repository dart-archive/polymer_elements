@TestOn('browser')
library polymer_elements.test.paper_progress_test;

import 'package:polymer_elements/paper_progress.dart';
import 'package:web_components/web_components.dart';
import 'package:test/test.dart';
import 'common.dart';

main() async {
  await initWebComponents();

  group('<paper-progress>', () {
    PaperProgress range;
    setUp(() {
      range = fixture('trivialProgress');
    });

    test('check default', () {
      expect(range.min, equals(0));
      expect(range.max, equals(100));
      expect(range.value, equals(0));
    });

    test('set value', () {
      range.value = 50;

      flushAsynchronousOperations();

      expect(range.value, equals(50));

      // test clamp value
      range.value = 60.1;

      flushAsynchronousOperations();

      expect(range.value, equals(60));
    });

    test('set max', () {
      range.max = 10;
      range.value = 11;

      expect(range.value, equals(range.max));
    });

    test('test ratio', () {
      range.max = 10;
      range.value = 5;

      flushAsynchronousOperations();

      expect(range.ratio, equals(50));
    });

    test('test secondary ratio', () {
      range.max = 10;
      range.secondaryProgress = 5;

      flushAsynchronousOperations();

      expect(range.secondaryRatio, equals(50));
    });

    test('set min', () {
      range.min = 10;
      range.max = 50;
      range.value = 30;

      flushAsynchronousOperations();

      expect(range.ratio, equals(50));

      range.value = 0;

      flushAsynchronousOperations();

      expect(range.value, equals(range.min));
    });

    test('set step', () {
      range.min = 0;
      range.max = 10;
      range.value = 5.1;

      flushAsynchronousOperations();

      expect(range.value, equals(5));

      range.step = 0.1;
      range.value = 5.1;

      flushAsynchronousOperations();

      expect(range.value, equals(5.1));
    });
  });
}
