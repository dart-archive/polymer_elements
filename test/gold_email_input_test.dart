@TestOn('browser')
library polymer_elements.test.gold_email_input;

import 'package:polymer_elements/gold_email_input.dart';
import 'package:web_components/web_components.dart';
import 'package:test/test.dart';
import 'common.dart';

main() async {
  await initWebComponents();

  group('basic', () {
    test('invalid input shows error', () {
      GoldEmailInput input = fixture('basic');
      input.value = '1234';
      input.jsElement.callMethod('_onInput');
      forceXIfStamp(input);

      var container = input.querySelector('paper-input-container');
      expect(container, isNotNull);
      expect(container.invalid, isTrue);

      var error = input.querySelector('paper-input-error');
      expect(error, isNotNull);
      expect(error.getComputedStyle().display, isNot('none'),
          reason: 'error is not display:none');
    });

    test('valid input does not show error', () {
      GoldEmailInput input = fixture('basic');
      input.value = 'batman@gotham.org';
      input.jsElement.callMethod('_onInput');
      forceXIfStamp(input);

      var container = input.querySelector('paper-input-container');
      expect(container, isNotNull);
      expect(container.invalid, isFalse);

      var error = input.querySelector('paper-input-error');
      expect(error, isNotNull);
      expect(error.getComputedStyle().display, equals('none'),
          reason: 'error should be display:none');
    }, skip: 'https://github.com/dart-lang/polymer_elements/issues/3');

    test('empty required input shows error', () {
      GoldEmailInput input = fixture('basic');
      forceXIfStamp(input);

      var error = input.querySelector('paper-input-error');
      expect(error, isNotNull);
      expect(error.getComputedStyle().display, isNot('none'),
          reason: 'error is not display:none');
    });
  });

  group('a11y', () {
    test('has aria-labelledby', () {
      GoldEmailInput input = fixture('basic');
      expect(input.inputElement.getAttribute('aria-labelledby'), isNotNull);
      expect(input.inputElement.getAttribute('aria-labelledby'),
          input.querySelector('label').id,
          reason: 'aria-labelledby points to the label');
    });
  });

  void testEmail(address, valid) {
    GoldEmailInput input = fixture('basic');
    forceXIfStamp(input);

    var container = input.querySelector('paper-input-container');
    expect(container, isNotNull);

    input.value = address;
    input.jsElement.callMethod('_onInput');
    var errorString = address + ' should be ' + (valid ? 'valid' : 'invalid');
    expect(container.invalid, equals(!valid), reason: errorString);
  }

  group('valid email address validation', () {
    test('valid email', () {
      testEmail('email@domain.com', true);
    });
    test('email with a dot in the address field', () {
      testEmail('firstname.lastname@domain.com', true);
    });
    test('email with a subdomain', () {
      testEmail('email@subdomain.domain.com', true);
    });
    test('weird tlds', () {
      testEmail('testing+contact@subdomain.domain.pizza', true);
    });
    test('plus sign is ok', () {
      testEmail('firstname+lastname@domain.com', true);
    });
    test('domain is valid ip', () {
      testEmail('email@123.123.123.123', true);
    });
    test('digits in address', () {
      testEmail('1234567890@domain.com', true);
    });
    test('dash in domain name', () {
      testEmail('email@domain-one.com', true);
    });
    test('dash in address field', () {
      testEmail('firstname-lastname@domain.com', true);
    });
    test('underscore in address field', () {
      testEmail('_______@domain-one.com', true);
    });
    test('dot in tld', () {
      testEmail('email@domain.co.jp', true);
    });
  });

  group('invalid email address validation', () {
    test('missing @ and domain', () {
      testEmail('plainaddress', false);
    });
    test('missing @', () {
      testEmail('email.domain.com', false);
    });
    test('garbage', () {
      testEmail('#@%^%#\$@#\$@#.com', false);
    });
    test('missing username', () {
      testEmail('@domain.com', false);
    });
    test('has spaces', () {
      testEmail('firstname lastname@domain.com', false);
    });
    test('encoded html', () {
      testEmail('Joe Smith <email@domain.com>', false);
    });
    test('two @ signs', () {
      testEmail('email@domain@domain.com', false);
    });
    test('unicode in address', () {
      testEmail('?????@domain.com', false);
    }, skip: 'https://github.com/dart-lang/polymer_elements/issues/3');
    test('text after address', () {
      testEmail('email@domain.com (Joe Smith)', false);
    });
    test('multiple dots in domain', () {
      testEmail('email@domain..com', false);
    });
  });
}
