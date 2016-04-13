// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@TestOn('browser')
library polymer_elements.test.gold_phone_input;

import 'dart:async';
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

    test('setting the value to undefined resets it to the empty string', () {
      var input = fixture('basic');
      input.value = null;
      expect(input.value, '');
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

    test('empty required input shows error on blur', () async {
      GoldPhoneInput input = fixture('required');
      forceXIfStamp(input);
      await new Future(() {});

      var container = Polymer.dom(input.root).querySelector('paper-input-container');
      var error = Polymer.dom(input.root).querySelector('paper-input-error');
      expect(error, isNotNull, reason: 'paper-input-error exists');
      expect(error
                 .getComputedStyle()
                 .visibility, 'hidden', reason: 'error is visibility:hidden');
      expect(container.invalid, isFalse);

      focus(input);
      blur(input);
      await new Future(() {});

      expect(!input.focused, isTrue, reason: 'input is blurred');
      expect(error
                 .getComputedStyle()
                 .visibility,isNot('hidden'), reason: 'error is not visibility:hidden');
      expect(container.invalid, isTrue);
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
    test('has aria-labelledby', () async {
      GoldPhoneInput input = fixture('basic');
      await new Future(() {});
      expect(input.inputElement.getAttribute('aria-labelledby'), isNotNull);
      expect(input.inputElement.getAttribute('aria-labelledby'),
          input.querySelector('label').id,
          reason: 'aria-labelledby points to the label');
    });

    test('required and error has aria-labelledby', () async {
      GoldPhoneInput input = fixture('required');
      await new Future(() {});
      expect(input.inputElement.getAttribute('aria-labelledby'), isNotNull);
      expect(input.inputElement.getAttribute('aria-labelledby'),
          input.querySelector('label').id,
          reason: 'aria-labelledby points to the label');
    });
  });


  group('caret position is preserved', ()
  {
    var input, ironInput;

    pretendToTypeACharacter(input, text, caret) {
      // When typing a character in an input, the browser natively advances
      // the caret from its original location.
      ironInput.value = text;
      ironInput.selectionStart = ironInput.selectionEnd = caret + 1;

      // Since imperatively setting the input value does not fire an event.
      // The user typing the value would, so manually fire the update.
      input.value = text;
    }

    pretendToDeleteACharacter(input, text, caret) {
      // When typing a character in an input, the browser natively moves back
      // the caret from its original location.
      ironInput.value = text;
      ironInput.selectionStart = ironInput.selectionEnd = caret - 1;

      // Since imperatively setting the input value does not fire an event.
      // The user typing the value would, so manually fire the update.
      input.value = text;
    }

    setUp(() {
      input = fixture('basic');
      ironInput = Polymer.dom(input.root).querySelector('input[is="iron-input"]');
    });

    test('001-0: adding a character after the 1', () {
      input.value = '001-0';

      var caret = 3;
      pretendToTypeACharacter(input, '0012-0', caret);
      expect(input.value, '001-20');

      // The cursor advaces by the one character you typed, and the one dash.
      expect(ironInput.selectionStart, caret + 2, reason: 'selectionStart is preserved');
      expect(ironInput.selectionEnd, caret + 2, reason: 'selectionEnd is preserved');
    });

    test('000-1: adding a character after the 1', () {
      input.value = '000-1';

      var caret = 5;
      pretendToTypeACharacter(input, '000-12', caret);
      expect(input.value, '000-12');

      // The cursor just advances by the one character you typed.
      expect(ironInput.selectionStart, caret + 1, reason: 'selectionStart is preserved');
      expect(ironInput.selectionEnd, caret + 1, reason: 'selectionEnd is preserved');
    });

    test('000-001: adding a character after the 1', () {
      input.value = '000-001';

      var caret = 7;
      pretendToTypeACharacter(input, '000-0012', caret);
      expect(input.value, '000-001-2');

      // The cursor advaces by the one character you typed, and the one new dash.
      expect(ironInput.selectionStart, caret + 2, reason: 'selectionStart is preserved');
      expect(ironInput.selectionEnd, caret + 2, reason: 'selectionEnd is preserved');
    });

    test('000-000-0001: adding a character after the 1', () {
      input.value = '000-000-0001';

      var caret = 12;
      pretendToTypeACharacter(input, '000-000-00012', caret);
      expect(input.value, '00000000012');

      // The cursor advaces by the one character you typed, but you lose 2 dashes
      expect(ironInput.selectionStart, caret - 1, reason: 'selectionStart is preserved');
      expect(ironInput.selectionEnd, caret - 1, reason: 'selectionEnd is preserved');
    });

    test('001-20: removing the 2', () {
      input.value = '001-20';

      var caret = 5;
      pretendToDeleteACharacter(input, '001-0', caret);
      expect(input.value, '001-0');

      // The cursor goes back by the one character you deleted.
      expect(ironInput.selectionStart, caret - 1, reason: 'selectionStart is preserved');
      expect(ironInput.selectionEnd, caret - 1, reason: 'selectionEnd is preserved');
    });

    test('000-12: removing the 2', () {
      input.value = '000-12';

      var caret = 5;
      pretendToDeleteACharacter(input, '000-1', caret);
      expect(input.value, '000-1');

      // The cursor goes back by the one character you deleted.
      expect(ironInput.selectionStart, caret - 1, reason: 'selectionStart is preserved');
      expect(ironInput.selectionEnd, caret - 1, reason: 'selectionEnd is preserved');
    });

    test('000-001-2: removing the 2', () {
      input.value = '000-001-2';

      var caret = 9;
      pretendToDeleteACharacter(input, '000-001-', caret);
      expect(input.value, '000-001');

      // The cursor goes back by the one character you deleted, and the one dash.
      expect(ironInput.selectionStart, caret - 2, reason: 'selectionStart is preserved');
      expect(ironInput.selectionEnd, caret - 2, reason: 'selectionEnd is preserved');
    });

    test('00000000012: removing the 2', () {
      input.value = '00000000012';

      var caret = 11;
      pretendToDeleteACharacter(input, '0000000001', caret);
      expect(input.value, '000-000-0001');

      // The cursor goes back by the one character you deleted, but gains two dashes.
      expect(ironInput.selectionStart, caret + 1, reason: 'selectionStart is preserved');
      expect(ironInput.selectionEnd, caret + 1, reason: 'selectionEnd is preserved');
    });
  });

}
