// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@TestOn('browser')
library polymer_elements.test.paper_progress_test;

import 'dart:async';
import 'dart:html';
import 'package:polymer_elements/paper_progress.dart';
import 'package:web_components/web_components.dart';
import 'package:test/test.dart';
import 'common.dart';

main() async {
  await initWebComponents();

  group('basic features', () {
    PaperProgress progress;

    setUp(() {
      progress = fixture('trivialProgress');
    });

    test('check default', () {
      expect(progress.min, equals(0));
      expect(progress.max, equals(100));
      expect(progress.value, equals(0));
    });

    test('set value', () {
      progress.value = 50;

      flushAsynchronousOperations();

      expect(progress.value, equals(50));

      // test clamp value
      progress.value = 60.1;

      flushAsynchronousOperations();

      expect(progress.value, equals(60));
    });

    test('set max', () {
      progress.max = 10;
      progress.value = 11;

      expect(progress.value, equals(progress.max));
    });

    test('test ratio', () {
      progress.max = 10;
      progress.value = 5;

      flushAsynchronousOperations();

      expect(progress.ratio, equals(50));
    });

    test('test secondary ratio', () {
      progress.max = 10;
      progress.secondaryProgress = 5;

      flushAsynchronousOperations();

      expect(progress.secondaryRatio, equals(50));
    });

    test('set min', () {
      progress.min = 10;
      progress.max = 50;
      progress.value = 30;

      flushAsynchronousOperations();

      expect(progress.ratio, equals(50));

      progress.value = 0;

      flushAsynchronousOperations();

      expect(progress.value, equals(progress.min));
    });

    test('set step', () {
      progress.min = 0;
      progress.max = 10;
      progress.value = 5.1;

      flushAsynchronousOperations();

      expect(progress.value, equals(5));

      progress.step = 0.1;
      progress.value = 5.1;

      flushAsynchronousOperations();

      expect(progress.value, equals(5.1));
    });
  });

  group('transiting class', () {
    var progress;

    setUp(() async {
      progress = fixture('transitingProgress');
      await new Future(() {});
    });

    test('progress bars', () {
      var stylesForPrimaryProgress =
          progress.$['primaryProgress'].getComputedStyle();
      var stylesForSecondaryProgress =
          progress.$['secondaryProgress'].getComputedStyle();
      var transitionProp = stylesForPrimaryProgress.transitionProperty;

      expect(
          transitionProp == 'transform' ||
              transitionProp == '-webkit-transform',
          isTrue);
      expect(stylesForPrimaryProgress.transitionDuration, '0.08s');

      transitionProp = stylesForSecondaryProgress.transitionProperty;

      expect(
          transitionProp == 'transform' ||
              transitionProp == '-webkit-transform',
          isTrue);
      expect(stylesForSecondaryProgress.transitionDuration, '0.08s');
    });
  });
}
