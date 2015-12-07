// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@TestOn('browser')
library polymer_elements.test.iron_autogrow_textarea_test;

import 'dart:async';
import 'package:polymer_elements/iron_autogrow_textarea.dart';
import 'package:test/test.dart';
import 'package:web_components/web_components.dart';
import 'common.dart';

main() async {
  await initWebComponents();

  group('basic', () {
    test('setting bindValue sets textarea value', () {
      IronAutogrowTextarea autogrow = fixture('basic');
      var textarea = autogrow.textarea;
      autogrow.bindValue = 'batman';
      expect(textarea.value, autogrow.bindValue,
          reason: 'textarea value equals to bindValue');
    });

    test('can set an initial bindValue', () {
      IronAutogrowTextarea autogrow = fixture('has-bindValue');
      expect(autogrow.textarea.value, 'foobar',
          reason: 'textarea value equals to initial bindValue');
    });

    test('can set an initial number of rows', () {
      IronAutogrowTextarea autogrow = fixture("rows");
      expect(autogrow.textarea.rows, 3, reason: 'textarea has rows=3');
    });

    test('adding rows grows the textarea', () {
      IronAutogrowTextarea autogrow = fixture('basic');
      var initialHeight = autogrow.offsetHeight;
      autogrow.bindValue = 'batman\nand\nrobin';
      var finalHeight = autogrow.offsetHeight;
      expect(finalHeight > initialHeight, isTrue);
    });

    test('removing rows shrinks the textarea', () {
      IronAutogrowTextarea autogrow = fixture('basic');
      autogrow.bindValue = 'batman\nand\nrobin';
      var initialHeight = autogrow.offsetHeight;
      autogrow.bindValue = 'batman';
      var finalHeight = autogrow.offsetHeight;
      expect(finalHeight < initialHeight, isTrue);
    });

    test('an undefined bindValue is the empty string', () {
      IronAutogrowTextarea autogrow = fixture('basic');
      var initialHeight = autogrow.offsetHeight;

      autogrow.bindValue = 'batman\nand\nrobin';
      var finalHeight = autogrow.offsetHeight;
      expect(finalHeight, greaterThan(initialHeight));

      autogrow.bindValue = null;
      expect(autogrow.offsetHeight, initialHeight);
      expect(autogrow.textarea.value, '');
    });

    test('textarea selection works', () {
      IronAutogrowTextarea autogrow = fixture('basic');
      var textarea = autogrow.textarea;
      autogrow.bindValue = 'batman\nand\nrobin';

      autogrow.selectionStart = 3;
      autogrow.selectionEnd = 5;

      expect(textarea.selectionStart, 3);
      expect(textarea.selectionEnd, 5);
    });

    group('focus/blur events', () {
      IronAutogrowTextarea input;

      setUp(() {
        input = fixture('basic');
      });

      test('focus/blur events fired on host element', () {
        var done = new Completer();
        var nFocusEvents = 0;
        var nBlurEvents = 0;
        input.on['focus'].take(1).listen((_) {
          nFocusEvents += 1;
          // setTimeout to wait for potentially more, erroneous events
          new Future(() {
            expect(nFocusEvents, 1, reason: 'one focus event fired');
            blur(input.textarea);
          });
        });
        input.on['blur'].take(1).listen((_) {
          nBlurEvents += 1;
          // setTimeout to wait for potentially more, erroneous events
          new Future(() {
            expect(nBlurEvents, 1, reason: 'one blur event fired');
            done.complete();
          });
        });
        focus(input.textarea);
        return done.future;
      });
    });

    group('validation', () {
      test('a required textarea with no text is invalid', () {
        IronAutogrowTextarea input = fixture('basic');
        input.required = true;
        expect(input.validate(), isFalse);
        input.bindValue = 'batman';
        expect(input.validate(), isTrue);
      });
    });
  });
}
