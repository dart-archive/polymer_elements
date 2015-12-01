// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@TestOn('browser')
library polymer_elements.test.gold_email_input;

import 'dart:async';
import 'package:polymer_elements/gold_email_input.dart';
import 'package:polymer_interop/polymer_interop.dart';
import 'package:web_components/web_components.dart';
import 'package:test/test.dart';
import 'common.dart';

main() async {
  await initWebComponents();

  group('basic', () {
    test('invalid input shows error', () {
      GoldEmailInput input = fixture('basic');
      input.value = '1234';
      forceXIfStamp(input);

      var container =
          Polymer.dom(input.root).querySelector('paper-input-container');
      expect(container, isNotNull);
      expect(container.invalid, isTrue);

      var error = Polymer.dom(input.root).querySelector('paper-input-error');
      expect(error, isNotNull, reason: 'paper-input-error exists');
      expect(error.getComputedStyle().visibility, equals('visible'),
          reason: 'error is visibility:visible');
    });

    test('valid input does not show error', () {
      GoldEmailInput input = fixture('basic');
      input.value = 'batman@gotham.org';
      forceXIfStamp(input);

      var container = input.querySelector('paper-input-container');
      expect(container, isNotNull);
      expect(container.invalid, isFalse);

      var error = input.querySelector('paper-input-error');
      expect(error, isNotNull);
      expect(error.getComputedStyle().visibility, equals('hidden'),
          reason: 'error should be visibility:hidden');
    });

    test('empty required input shows error on blur', () {
      GoldEmailInput input = fixture('basic');
      forceXIfStamp(input);

      var error = input.querySelector('paper-input-error');
      expect(error, isNotNull);
      expect(error.getComputedStyle().visibility, equals('hidden'),
          reason: 'error is visibility:hidden');

      input.on['blur'].first.then((event) {
        expect(input.focused, isFalse, reason: 'input is blurred');
        expect(error.getComputedStyle().visibility, isNot('hidden'),
            reason: 'error is not visibility:hidden');
      });
      focus(input);
      blur(input);
    });
  });

  group('a11y', () {
    test('has aria-labelledby', () async {
      GoldEmailInput input = fixture('basic');
      await new Future(() {});
      expect(input.inputElement.getAttribute('aria-labelledby'), isNotNull);
      expect(input.inputElement.getAttribute('aria-labelledby'),
          input.querySelector('label').id,
          reason: 'aria-labelledby points to the label');
    });
  });

  void testEmail(fixtureName, address, valid) {
    GoldEmailInput input = fixture(fixtureName);
    forceXIfStamp(input);

    var container = input.querySelector('paper-input-container');
    expect(container, isNotNull);

    input.value = address;
    var errorString = '$address should be ${valid ? 'valid' : 'invalid'}';
    expect(container.invalid, equals(!valid), reason: errorString);
  }

  group('valid email address validation', () {
    test('valid email', () {
      testEmail('basic', 'email@domain.com', true);
    });
    test('email with a dot in the address field', () {
      testEmail('basic', 'firstname.lastname@domain.com', true);
    });
    test('email with a subdomain', () {
      testEmail('basic', 'email@subdomain.domain.com', true);
    });
    test('weird tlds', () {
      testEmail('basic', 'testing+contact@subdomain.domain.pizza', true);
    });
    test('plus sign is ok', () {
      testEmail('basic', 'firstname+lastname@domain.com', true);
    });
    test('domain is valid ip', () {
      testEmail('basic', 'email@123.123.123.123', true);
    });
    test('digits in address', () {
      testEmail('basic', '1234567890@domain.com', true);
    });
    test('dash in domain name', () {
      testEmail('basic', 'email@domain-one.com', true);
    });
    test('dash in address field', () {
      testEmail('basic', 'firstname-lastname@domain.com', true);
    });
    test('underscore in address field', () {
      testEmail('basic', '_______@domain-one.com', true);
    });
    test('dot in tld', () {
      testEmail('basic', 'email@domain.co.jp', true);
    });
  });

  group('invalid email address validation', () {
    test('missing @ and domain', () {
      testEmail('basic', 'plainaddress', false);
    });
    test('missing @', () {
      testEmail('basic', 'email.domain.com', false);
    });
    test('garbage', () {
      testEmail('basic', '#@%^%#\$@#\$@#.com', false);
    });
    test('missing username', () {
      testEmail('basic', '@domain.com', false);
    });
    test('has spaces', () {
      testEmail('basic', 'firstname lastname@domain.com', false);
    });
    test('encoded html', () {
      testEmail('basic', 'Joe Smith <email@domain.com>', false);
    });
    test('two @ signs', () {
      testEmail('basic', 'email@domain@domain.com', false);
    });
    test('unicode in address', () {
      testEmail('basic', '൰ඎළ@domain.com', false);
    });
    test('text after address', () {
      testEmail('basic', 'email@domain.com (Joe Smith)', false);
    });
    test('multiple dots in domain', () {
      testEmail('basic', 'email@domain..com', false);
    });
  });

  group('custom email address validation', () {
    test('invalid email', () {
      testEmail('custom-regex', 'batman', false);
    });

    test('valid email', () {
      testEmail('custom-regex', 'cat', true);
    });

    test('valid complex email', () {
      testEmail('custom-regex', 'supercat', true);
    });
  });

  group('empty regex means no validation', () {
    test('empty string is valid', () {
      testEmail('no-regex', '', true);
    });

    test('random string is valid', () {
      testEmail('no-regex', 'batman', true);
    });
  });
}
