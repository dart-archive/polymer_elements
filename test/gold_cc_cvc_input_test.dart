// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@TestOn('browser')
library polymer_elements.test.gold_cc_ccv_input;

import 'dart:async';
import 'package:polymer_elements/gold_cc_cvc_input.dart';
import 'package:polymer_elements/paper_input_error.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'package:web_components/web_components.dart';
import 'package:test/test.dart';
import 'common.dart';

main() async {
  await initWebComponents();

  group('basic', () {
    test('max length for a non-amex cc is 3', () {
      GoldCcCvcInput input = fixture('basic');
      expect(input.inputElement.maxLength, 3);
    });

    test('max length for an amex cc is 4', () {
      GoldCcCvcInput input = fixture('amex');

      expect(input.inputElement.maxLength, 4);
    });

    test('valid input is ok', () {
      GoldCcCvcInput input = fixture('required');
      input.value = '123';
      forceXIfStamp(input);

      var container = input.querySelector('paper-input-container');
      expect(container, isNotNull);
      expect(container.invalid, isFalse);

      PaperInputError error =
          Polymer.dom(input.root).querySelector('paper-input-error');
      expect(error, isNotNull, reason: 'paper-input-error exists');
      expect(error.getComputedStyle().visibility, 'hidden',
          reason: 'error is visibility:hidden');
    });

    test('invalid input is not ok', () {
      GoldCcCvcInput input = fixture('required');
      input.value = '13';
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

    test('empty required input shows error on blur', () {
      GoldCcCvcInput input = fixture('required');
      forceXIfStamp(input);

      var error = Polymer.dom(input.root).querySelector('paper-input-error');
      expect(error, isNotNull, reason: 'paper-input-error exists');
      expect(error.getComputedStyle().visibility, equals('hidden'),
          reason: 'should not be visibility:visible');

      expect(error.getComputedStyle().visibility, 'hidden',
          reason: 'error is visibility:hidden');
      focus(input);
      blur(input);

      expect(error.getComputedStyle().visibility, isNot('hidden'),
          reason: 'error is not visibility:hidden');
    });

    test('invalid input shows error message after manual validation', () {
      GoldCcCvcInput input = fixture('amex');
      forceXIfStamp(input);

      var error = input.querySelector('paper-input-error');
      expect(error, isNotNull);

      // The error message is only displayed after manual validation.
      expect(error.getComputedStyle().visibility, equals('hidden'),
          reason: 'error should be visibility:hidden');
      input.validate();
      expect(error.getComputedStyle().visibility, isNot('hidden'),
          reason: 'error should not be visibility:hidden');
    });
  });

  group('a11y', () {
    test('has aria-labelledby', () async {
      GoldCcCvcInput input = fixture('basic');
      await new Future(() {});
      expect(input.inputElement.getAttribute('aria-labelledby'), isNotNull);
      expect(input.inputElement.getAttribute('aria-labelledby'),
          input.querySelector('label').id,
          reason: 'aria-labelledby points to the label');
    });
    test('required and error has aria-labelledby', () async {
      GoldCcCvcInput input = fixture('required');
      await new Future(() {});
      expect(input.inputElement.getAttribute('aria-labelledby'), isNotNull);
      expect(input.inputElement.getAttribute('aria-labelledby'),
          input.querySelector('label').id,
          reason: 'aria-labelledby points to the label');
    });
  });
}
