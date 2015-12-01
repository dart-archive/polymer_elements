// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@TestOn('browser')
library polymer_elements.test.gold_cc_input;

import 'dart:async';
import 'package:polymer_elements/gold_cc_input.dart';
import 'package:polymer_elements/iron_input.dart';
import 'package:polymer_elements/paper_input_error.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'package:web_components/web_components.dart';
import 'package:test/test.dart';
import 'common.dart';

main() async {
  await initWebComponents();

  group('basic', () {
    test('input is spaced out correctly', () {
      GoldCcInput input = fixture('basic');
      input.value = '12345678';
      expect(input.value, equals('1234 5678'));
    });

    test('invalid input is not ok', () {
      GoldCcInput input = fixture('required');
      input.value = '1234';
      forceXIfStamp(input);

      var container = input.querySelector('paper-input-container');
      expect(container, isNotNull);
      expect(container.invalid, isTrue);
      expect(input.cardType, equals(''));

      PaperInputError error =
          Polymer.dom(input.root).querySelector('paper-input-error');
      expect(error, isNotNull, reason: 'paper-input-error exists');
      expect(error.getComputedStyle().visibility, isNot('hidden'),
          reason: 'error is not visibility:hidden');
    });

    test('valid input is ok', () {
      GoldCcInput input = fixture('required');
      input.value = '4000000000000002';
      forceXIfStamp(input);

      var container = input.querySelector('paper-input-container');
      expect(container, isNotNull);
      expect(container.invalid, isFalse);
      expect(input.cardType, equals('visa'));
    });

    test('empty required input shows error on blur', () {
      GoldCcInput input = fixture('required');
      forceXIfStamp(input);

      PaperInputError error = input.querySelector('paper-input-error');
      expect(error, isNotNull);
      expect(error.getComputedStyle().visibility, equals('hidden'),
          reason: 'error should be visibility:hidden');

      expect(error.getComputedStyle().visibility, 'hidden',
          reason: 'error is visibility:hidden');

      var done = input.on['blur'].first.then((event) {
        expect(input.focused, isFalse, reason: 'input is blurred');
        expect(error.getComputedStyle().visibility, isNot('hidden'),
            reason: 'error is not visibility:hidden');
      });
      focus(input);
      blur(input);

      return done;
    });

    test('invalid input shows error message after manual validation', () {
      GoldCcInput input = fixture('ErrorWithoutAutoValidate');
      forceXIfStamp(input);

      PaperInputError error = input.querySelector('paper-input-error');
      expect(error, isNotNull);

      // The error message is only displayed after manual validation.
      expect(error.getComputedStyle().visibility, equals('hidden'),
          reason: 'error is visibility:hidden');
      input.validate();
      expect(error.getComputedStyle().visibility, isNot('hidden'),
          reason: 'error is not visibility:hidden');
    });

    test('caret position is preserved', () {
      GoldCcInput input = fixture('required');
      IronInput ironInput = input.querySelector('input[is="iron-input"]');
      input.value = '1111 1111';
      ironInput.selectionStart = 2;
      ironInput.selectionEnd = 2;
      input.jsElement
          .callMethod('_onValueChanged', ['1122 1111 11', '1111 1111']);

      expect(ironInput.selectionStart, equals(2),
          reason: 'selectionStart should be preserved');
      expect(ironInput.selectionEnd, equals(2),
          reason: 'selectionEnd should be preserved');
    });
  });

  group('a11y', () {
    test('has aria-labelledby', () async {
      GoldCcInput input = fixture('basic');
      await new Future(() {});
      expect(input.inputElement.getAttribute('aria-labelledby'), isNotNull);
      expect(input.inputElement.getAttribute('aria-labelledby'),
          input.querySelector('label').id,
          reason: 'aria-labelledby points to the label');
    });

    test('required and error has aria-labelledby', () async {
      GoldCcInput input = fixture('required');
      await new Future(() {});
      expect(input.inputElement.getAttribute('aria-labelledby'), isNotNull);
      expect(input.inputElement.getAttribute('aria-labelledby'),
          input.querySelector('label').id,
          reason: 'aria-labelledby points to the label');
    });
  });
}
