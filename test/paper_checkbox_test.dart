// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@TestOn('browser')
library polymer_elements.test.paper_checkbox_test;

import 'dart:async';
import 'package:polymer_elements/paper_checkbox.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'package:web_components/web_components.dart';
import 'package:test/test.dart';
import 'common.dart';

main() async {
  await initWebComponents();

  group('defaults', () {
    PaperCheckbox c1;

    setUp(() async {
      c1 = fixture('NoLabel');
      await new Future(() {});
    });

    test('check checkbox via click', () {
      Completer done = new Completer();

      c1.on['click'].take(1).listen((_) {
        expect(c1.getAttribute('aria-checked'), equals('true'));
        expect(c1.checked, isTrue);
        done.complete();
      });
      tap(c1);

      return done.future;
    });

    test('toggle checkbox via click', () {
      Completer done = new Completer();
      c1.checked = true;

      c1.on['click'].take(1).listen((_) {
        expect(c1.getAttribute('aria-checked'), equals('false'));
        expect(c1.checked, isFalse);
        done.complete();
      });
      tap(c1);

      return done.future;
    });

    test('disabled checkbox cannot be clicked', () async {
      c1.disabled = true;
      c1.checked = true;

      tap(c1);
      await wait(1);

      expect(c1.getAttribute('aria-checked'), equals('true'));
      expect(c1.checked, isTrue);
    });

    test('checkbox can be validated', () {
      c1.required = true;
      expect(c1.validate(null), isFalse);

      c1.checked = true;
      expect(c1.validate(null), isTrue);
    });

    test('disabled checkbox is always valid', () {
      c1.disabled = true;
      c1.required = true;
      expect(c1.validate(null), isTrue);

      c1.checked = true;
      expect(c1.validate(null), isTrue);
    });

    test('checkbox can check sizes', () {
      var c2 = fixture('WithDifferentSizes');
      var normal = c2[0].getBoundingClientRect();
      var giant = c2[1].getBoundingClientRect();
      var tiny = c2[2].getBoundingClientRect();

      expect(5, lessThanOrEqualTo(tiny.height));
      expect(tiny.height, lessThan(normal.height));
      expect(normal.height, lessThan(giant.height));
      // Dart Note: upped to `60` from `50`
      expect(giant.height, lessThanOrEqualTo(60));

      expect(5, lessThanOrEqualTo(tiny.width));
      expect(tiny.width, lessThan(normal.width));
      expect(normal.width, lessThan(giant.width));
      // Dart Note: upped to `60` from `50`
      expect(giant.width, lessThanOrEqualTo(60));
    });

    suite('checkbox line-height', () {
      var large;
      var small;

      setup(() {
        var checkboxes = fixture('WithLineHeight');
        large = checkboxes[0];
        small = checkboxes[1];
      });

      test('checkboxes with >1 line-height have an equal height', () {
        var largeRect = large.getBoundingClientRect();
        var largeStyle = large.getComputedStyle();

        $assert.isTrue(largeRect.height == 3 * parseFloat(largeStyle.fontSize));
      });

      test('checkbox with <1 line-height are at least 1em tall', () {
        var smallRect = small.getBoundingClientRect();
        var smallStyle = small.getComputedStyle();

        $assert.isTrue(smallRect.height >= 1 * parseFloat(smallStyle.fontSize));
      });
    });

  });

  group('a11y', () {
    PaperCheckbox c1;
    PaperCheckbox c2;

    setUp(() {
      c1 = fixture('NoLabel');
      c2 = fixture('WithLabel');
    });

    test('has aria role "checkbox"', () {
      expect(c1.getAttribute('role'), equals('checkbox'));
      expect(c2.getAttribute('role'), equals('checkbox'));
    });

    test('checkbox with no label has no aria label', () {
      expect(c1.getAttribute('aria-label'), isNull);
    });

    test('checkbox respects the user set aria-label', () {
      PaperCheckbox c = fixture('AriaLabel');
      expect(c.getAttribute('aria-label'), equals("Batman"));
    });

    // TODO(jakemac): Investigate these
    // a11ySuite('NoLabel');
    // a11ySuite('WithLabel');
    // a11ySuite('AriaLabel');
  });
}
