// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@TestOn('browser')
library polymer_elements.test.gold_phone_input;

import 'package:polymer_elements/gold_phone_input.dart';
import 'package:polymer_elements/iron_input.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'package:web_components/web_components.dart';
import 'package:test/test.dart';
import 'common.dart';

main() async {
  await initWebComponents();

  group('basic', () {
    test('input is spaced out correctly', () {
      GoldPhoneInput input = fixture('basic');
      input.value = '1231112222';
      expect(input.value, equals('123-111-2222'));
    });

    test('invalid input is not ok', () {
      GoldPhoneInput input = fixture('required');
      input.value = '1234';
      forceXIfStamp(input);

      var container = input.querySelector('paper-input-container');
      expect(container, isNotNull);
      expect(container.invalid, isTrue);

      var error = Polymer.dom(input.root).querySelector('paper-input-error');
      expect(error, isNotNull, reason: 'paper-input-error exists');
      expect(error.getComputedStyle().visibility, isNot('hidden'),
          reason: 'error is not visibility:hidden');
    });

    test('valid input is ok', () {
      GoldPhoneInput input = fixture('required');
      input.value = '1231112222';
      forceXIfStamp(input);

      var container = input.querySelector('paper-input-container');
      expect(container, isNotNull);
      expect(container.invalid, isFalse);

      var error = Polymer.dom(input.root).querySelector('paper-input-error');
      expect(error, isNotNull, reason: 'paper-input-error exists');
      expect(error.getComputedStyle().visibility, 'hidden',
          reason: 'error is visibility:hidden');
    });

    test('empty required input shows error on blur', () {
      GoldPhoneInput input = fixture('required');
      forceXIfStamp(input);

      var error = input.querySelector('paper-input-error');
      expect(error, isNotNull);
      expect(error.getComputedStyle().visibility, 'hidden',
          reason: 'error should be visibility:hidden');

      var done = input.on['blur'].first.then((event) {
        expect(input.focused, isFalse, reason: 'input is blurred');
        expect(error.getComputedStyle().visibility, isNot('hidden'),
            reason: 'error is not visibility:hidden');
      });
      focus(input.inputElement);
      blur(input.inputElement);
    });

    test('caret position is preserved', () {
      GoldPhoneInput input = fixture('required');
      IronInput ironInput = input.querySelector('input[is="iron-input"]');
      input.value = '111-111';
      ironInput.selectionStart = 2;
      ironInput.selectionEnd = 2;
      input.jsElement.callMethod('_onValueChanged', ['111-111-1', '111-111']);

      expect(ironInput.selectionStart, equals(2),
          reason: 'selectionStart should be preserved');
      expect(ironInput.selectionEnd, equals(2),
          reason: 'selectionEnd should be preserved');
    });
  });

  group('a11y', () {
    test('has aria-labelledby', () {
      GoldPhoneInput input = fixture('basic');
      expect(input.inputElement.getAttribute('aria-labelledby'), isNotNull);
      expect(input.inputElement.getAttribute('aria-labelledby'),
          input.querySelector('label').id,
          reason: 'aria-labelledby points to the label');
    });

    test('required and error has aria-labelledby', () {
      GoldPhoneInput input = fixture('required');
      expect(input.inputElement.getAttribute('aria-labelledby'), isNotNull);
      expect(input.inputElement.getAttribute('aria-labelledby'),
          input.querySelector('label').id,
          reason: 'aria-labelledby points to the label');
    });
  });
}
