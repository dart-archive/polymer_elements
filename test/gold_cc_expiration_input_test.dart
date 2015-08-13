@TestOn('browser')
library polymer_elements.test.gold_cc_expiration_input;

import 'package:polymer_elements/gold_cc_expiration_input.dart';
import 'package:polymer_elements/date_input.dart';
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
    });

    test('misformed dates are not ok', () {
      GoldCcExpirationInput input = fixture('basic');
      input.value = '33/33';
      forceXIfStamp(input);

      var container = input.querySelector('paper-input-container');
      expect(container, isNotNull);
      expect(container.invalid, isTrue);
    });

    test('past dates are not ok', () {
      GoldCcExpirationInput input = fixture('basic');
      input.value = '11/00';
      forceXIfStamp(input);

      var container = input.querySelector('paper-input-container');
      expect(container, isNotNull);
      expect(container.invalid, isTrue);
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
    });

    test('value is updated correctly ', () {
      GoldCcExpirationInput input = fixture('basic');

      (input.querySelector('.paper-input-input') as DateInput).month = '11';
      (input.querySelector('.paper-input-input') as DateInput).year = '15';
      expect(input.value, equals('11/15'));
    });

    test('empty required input shows error', () {
      GoldCcExpirationInput input = fixture('basic');
      forceXIfStamp(input);

      var error = input.querySelector('paper-input-error');
      expect(error, isNotNull);
      expect(error.getComputedStyle().display, isNot('none'),
          reason: 'error should not be display:none');
    });
  });

  group('a11y', () {
    test('has aria-labelledby', () {
      GoldCcExpirationInput input = fixture('basic');
      var month = input.querySelectorAll('input')[0];
      var year = input.querySelectorAll('input')[1];
      var label = input.querySelector('label').id;

      expect(month, isNotNull);
      expect(year, isNotNull);

      expect(month.getAttribute('aria-labelledby'), isNotNull);
      expect(year.getAttribute('aria-labelledby'), isNotNull);

      expect(
          month.getAttribute('aria-labelledby'), equals('$label monthLabel'));
      expect(
          year.getAttribute('aria-labelledby'), equals('$label yearLabel'));
    });
  });
}
