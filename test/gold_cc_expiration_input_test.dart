// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@TestOn('browser')
library polymer_elements.test.gold_cc_expiration_input;

import 'dart:async';
import 'package:polymer_elements/gold_cc_expiration_input.dart';
import 'package:polymer_elements/date_input.dart';
import 'package:polymer_elements/paper_input_error.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'package:web_components/web_components.dart';
import 'package:test/test.dart';
import 'common.dart';

main() async {
  await initWebComponents();

  group('basic', () {
    test('invalid input is not ok', () {
      GoldCcExpirationInput input = fixture('basic');
      input.value = '1234';
      forceXIfStamp(input);

      var container = input.querySelector('paper-input-container');
      expect(container, isNotNull);
      expect(container.invalid, isTrue);

      PaperInputError error =
          Polymer.dom(input.root).querySelector('paper-input-error');
      expect(error, isNotNull, reason: 'paper-input-error exists');
      expect(error.getComputedStyle().visibility, isNot('hidden'),
          reason: 'error is not visibility:hidden');
    });

    test('misformed dates are not ok', () {
      GoldCcExpirationInput input = fixture('basic');
      input.value = '33/33';
      forceXIfStamp(input);

      var container = input.querySelector('paper-input-container');
      expect(container, isNotNull);
      expect(container.invalid, isTrue);

      PaperInputError error =
          Polymer.dom(input.root).querySelector('paper-input-error');
      expect(error, isNotNull, reason: 'paper-input-error exists');
      expect(error.getComputedStyle().visibility, isNot('hidden'),
          reason: 'error is not visibility:hidden');
    });

    test('past dates are not ok', () {
      GoldCcExpirationInput input = fixture('basic');
      input.value = '11/00';
      forceXIfStamp(input);

      var container = input.querySelector('paper-input-container');
      expect(container, isNotNull);
      expect(container.invalid, isTrue);

      PaperInputError error =
          Polymer.dom(input.root).querySelector('paper-input-error');
      expect(error, isNotNull, reason: 'paper-input-error exists');
      expect(error.getComputedStyle().visibility, isNot('hidden'),
          reason: 'error is not visibility:hidden');
    });

    test('future dates are ok', () {
      GoldCcExpirationInput input = fixture('basic');
      // Note: this test will start failing in 2099. Apologies, future maintainers.
      input.value = '11/99';
      forceXIfStamp(input);

      var container = input.querySelector('paper-input-container');
      expect(container, isNotNull);
      expect(container.invalid, isFalse);
      expect(input.value, equals('11/99'));

      PaperInputError error =
          Polymer.dom(input.root).querySelector('paper-input-error');
      expect(error, isNotNull, reason: 'paper-input-error exists');
      expect(error.getComputedStyle().visibility, 'hidden',
          reason: 'error is visibility:hidden');
    });

    test('value is updated correctly ', () {
      GoldCcExpirationInput input = fixture('basic');

      (input.querySelector('.paper-input-input') as DateInput).month = '11';
      (input.querySelector('.paper-input-input') as DateInput).year = '15';
      expect(input.value, equals('11/15'));
    });

    test('empty required input shows error on blur', () {
      GoldCcExpirationInput input = fixture('basic');
      forceXIfStamp(input);

      PaperInputError error = input.querySelector('paper-input-error');
      expect(error, isNotNull);
      expect(error.getComputedStyle().visibility, 'hidden',
          reason: 'error should not be display:none');

      var done = input.on['blur'].first.then((event) {
        expect(input.focused, isFalse, reason: 'input is blurred');
        expect(error.getComputedStyle().visibility, isNot('hidden'),
            reason: 'error is not visibility:hidden');
      });
      focus(input.inputElement);
      blur(input.inputElement);

      return done;
    });
  });

  group('a11y', () {
    test('has aria-labelledby', () async {
      GoldCcExpirationInput input = fixture('basic');
      await new Future(() {});
      var month = input.querySelectorAll('input')[0];
      var year = input.querySelectorAll('input')[1];
      var label = input.querySelector('label').id;

      expect(month, isNotNull);
      expect(year, isNotNull);

      expect(month.getAttribute('aria-labelledby'), isNotNull);
      expect(year.getAttribute('aria-labelledby'), isNotNull);

      expect(
          month.getAttribute('aria-labelledby'), equals('$label monthLabel'));
      expect(year.getAttribute('aria-labelledby'), equals('$label yearLabel'));
    });
  });
}
