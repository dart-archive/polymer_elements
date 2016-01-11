@TestOn('browser')
library polymer_elements.test.iron_checked_element_behavior_test;

import 'dart:async';
import 'dart:convert';
import 'dart:html';
import 'dart:js';
import 'package:polymer_interop/polymer_interop.dart';
import 'package:polymer/polymer.dart';
import 'package:test/test.dart';
import 'package:web_components/web_components.dart';
import 'fixtures/simple_checkbox.dart';
import 'common.dart';

main() async {
  await initPolymer();

  group('basic', () {
    test('can be checked', () {
      SimpleCheckbox c = fixture('basic');
      expect(c.checked, isFalse);
      c.checked = true;
      expect(c.checked, isTrue);
    });

    test('can be unchecked', () {
      SimpleCheckbox c = fixture('checked');
      expect(c.checked, isTrue);
      c.checked = false;
      expect(c.checked, isFalse);
    });

    test('invalid if required and not checked', () {
      SimpleCheckbox c = fixture('basic');
      c.required = true;
      expect(c.checked, isFalse);
      expect(c.jsElement.callMethod('validate'), isFalse);
      expect(c.invalid, isTrue);
    });

    test('valid if required and checked', () {
      SimpleCheckbox c = fixture('basic');
      c.required = true;
      c.checked = true;
      expect(c.checked, isTrue);
      expect(c.jsElement.callMethod('validate'), isTrue);
      expect(c.invalid, isFalse);
    });

    test('valid if not required and not checked', () {
      SimpleCheckbox c = fixture('basic');
      expect(c.checked, isFalse);
      expect(c.jsElement.callMethod('validate'), isTrue);
      expect(c.invalid, isFalse);
    });

    test('has a default value of "on", always', () {
      SimpleCheckbox c = fixture('basic');
      expect(c.value, 'on');

      c.checked = true;
      expect(c.value, 'on');
    });

    test('does not stomp over user defined value when checked', () {
      SimpleCheckbox c = fixture('with-value');
      expect(c.value, 'batman');

      c.checked = true;
      expect(c.value, 'batman');
    });

    test('value returns "on" when no explicit value is specified', () {
      var c = fixture('basic');

      expect(c.value, 'on', reason:'returns "on"');
    });

    test('value returns the value when an explicit value is set', () {
      var c = fixture('basic');

      c.value = 'abc';
      expect(c.value, 'abc', reason:'returns "abc"');

      c.value = '123';
      expect(c.value, '123', reason:'returns "123"');
    });

    test('value returns "on" when value is set to undefined', () {
      var c = fixture('basic');

      c.value = 'abc';
      expect(c.value, 'abc', reason:'returns "abc"');

      c.value = null; // TODO: DART PORT : null == undefined in JS ?
      expect(c.value, 'on', reason:'returns "on"');
    });


  });

  group('a11y', () {
    test('setting `required` sets `aria-required=true`', () {
      SimpleCheckbox c = fixture('basic');
      c.required = true;
      expect(c.getAttribute('aria-required'), 'true');
      c.required = false;
      expect(c.attributes.containsKey('aria-required'), isFalse);
    });

    test('setting `invalid` sets `aria-invalid=true`', () {
      SimpleCheckbox c = fixture('basic');
      c.invalid = true;
      expect(c.getAttribute('aria-invalid'), 'true');
      c.invalid = false;
      expect(c.attributes.containsKey('aria-invalid'), isFalse);
    });
  });
}
