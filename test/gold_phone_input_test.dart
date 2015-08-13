@TestOn('browser')
library polymer_elements.test.gold_phone_input;

import 'package:polymer_elements/gold_phone_input.dart';
import 'package:polymer_elements/iron_input.dart';
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
    });

    test('valid input is ok', () {
      GoldPhoneInput input = fixture('required');
      input.value = '1231112222';
      forceXIfStamp(input);

      var container = input.querySelector('paper-input-container');
      expect(container, isNotNull);
      expect(container.invalid, isFalse);
    });

    test('empty required input shows error', () {
      GoldPhoneInput input = fixture('required');
      forceXIfStamp(input);

      var error = input.querySelector('paper-input-error');
      expect(error, isNotNull);
      expect(error.getComputedStyle().display, isNot('none'),
          reason: 'error should not be display:none');
    });

    test('caret position is preserved', () {
      GoldPhoneInput input = fixture('required');
      IronInput ironInput = input.querySelector('input[is="iron-input"]');
      input.value = '111-111-1';
      ironInput.selectionStart = 2;
      ironInput.selectionEnd = 2;
      input.jsElement.callMethod('_computeValue', ['112-111-11']);

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
