@TestOn('browser')
library polymer_elements.test.gold_zip_input;

import 'package:polymer_elements/gold_zip_input.dart';
import 'package:polymer_elements/iron_input.dart';
import 'package:web_components/web_components.dart';
import 'package:test/test.dart';
import 'common.dart';

main() async {
  await initWebComponents();

  group('basic', () {
    test('invalid input is not ok', () {
      GoldZipInput input = fixture('basic');
      input.value = '1234';
      forceXIfStamp(input);

      var container = input.querySelector('paper-input-container');
      expect(container, isNotNull);
      expect(container.invalid, isTrue);
    });

    test('input is formatted ok', () {
      GoldZipInput input = fixture('basic');
      input.value = '902101111';
      expect(input.value, equals('90210-1111'));
    });

    test('spaces instead of dashes are not ok', () {
      GoldZipInput input = fixture('basic');
      input.value = '90210 1111';
      forceXIfStamp(input);

      var container = input.querySelector('paper-input-container');
      expect(container, isNotNull);
      expect(container.invalid, isTrue);
    });

    test('short zipcodes are ok', () {
      GoldZipInput input = fixture('basic');
      input.value = '94109';
      forceXIfStamp(input);

      var container = input.querySelector('paper-input-container');
      expect(container, isNotNull);
      expect(container.invalid, isFalse);
    });

    test('full zipcodes are ok', () {
      GoldZipInput input = fixture('basic');
      input.value = '94109-1234';
      forceXIfStamp(input);

      var container = input.querySelector('paper-input-container');
      expect(container, isNotNull);
      expect(container.invalid, isFalse);
    });

    test('empty required input shows error', () {
      GoldZipInput input = fixture('basic');
      forceXIfStamp(input);

      var error = input.querySelector('paper-input-error');
      expect(error, isNotNull);
      expect(error.getComputedStyle().display, isNot('none'),
          reason: 'error should not be display:none');
    });

    test('caret position is preserved', () {
      GoldZipInput input = fixture('basic');
      IronInput ironInput = input.querySelector('input[is="iron-input"]');
      input.value = '11111-11';
      ironInput.selectionStart = 2;
      ironInput.selectionEnd = 2;
      input.jsElement.callMethod('_computeValue', ['11221-1111']);

      expect(ironInput.selectionStart, equals(2),
          reason: 'selectionStart should be preserved');
      expect(ironInput.selectionEnd, equals(2),
          reason: 'selectionEnd should be preserved');
    });
  });

  group('a11y', () {
    test('has aria-labelledby', () {
      GoldZipInput input = fixture('basic');
      expect(input.inputElement.getAttribute('aria-labelledby'), isNotNull);
      expect(input.inputElement.getAttribute('aria-labelledby'),
          input.querySelector('label').id,
          reason: 'aria-labelledby points to the label');
    });
  });
}
