@TestOn('browser')
library polymer_elements.test.gold_cc_input;

import 'package:polymer_elements/gold_cc_input.dart';
import 'package:polymer_elements/iron_input.dart';
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

    test('empty required input shows error', () {
      GoldCcInput input = fixture('required');
      forceXIfStamp(input);

      var error = input.querySelector('paper-input-error');
      expect(error, isNotNull);
      expect(error.getComputedStyle().visibility, equals('visible'),
          reason: 'error should not be visibility:visible');
    });

    test('invalid input shows error message after manual validation', () {
      GoldCcInput input = fixture('ErrorWithoutAutoValidate');
      forceXIfStamp(input);

      var error = input.querySelector('paper-input-error');
      expect(error, isNotNull);

      // The error message is only displayed after manual validation.
      expect(error.getComputedStyle().visibility, equals('hidden'),
          reason: 'error should be visibility:hidden');
      input.validate();
      expect(error.getComputedStyle().visibility, equals('visible'),
          reason: 'error should not be visibility:visible');
    });

    test('caret position is preserved', () {
      GoldCcInput input = fixture('required');
      IronInput ironInput = input.querySelector('input[is="iron-input"]');
      input.value = '1111 1111';
      ironInput.selectionStart = 2;
      ironInput.selectionEnd = 2;
      input.jsElement.callMethod('_computeValue', ['1122 1111 11']);

      expect(ironInput.selectionStart, equals(2),
          reason: 'selectionStart should be preserved');
      expect(ironInput.selectionEnd, equals(2),
          reason: 'selectionEnd should be preserved');
    });
  });

  group('a11y', () {
    test('has aria-labelledby', () {
      GoldCcInput input = fixture('basic');
      expect(input.inputElement.getAttribute('aria-labelledby'), isNotNull);
      expect(input.inputElement.getAttribute('aria-labelledby'),
          input.querySelector('label').id,
          reason: 'aria-labelledby points to the label');
    });
    test('required and error has aria-labelledby', () {
      GoldCcInput input = fixture('required');
      expect(input.inputElement.getAttribute('aria-labelledby'), isNotNull);
      expect(input.inputElement.getAttribute('aria-labelledby'),
          input.querySelector('label').id,
          reason: 'aria-labelledby points to the label');
    });
  });
}
