@TestOn('browser')
library polymer_elements.test.iron_input_test;

import 'dart:async';
import 'dart:convert';
import 'dart:html';
import 'dart:js';
import 'package:polymer_elements/iron_input.dart';
import 'package:test/test.dart';
import 'package:web_components/web_components.dart';
import 'common.dart';

main() async {
  await initWebComponents();
  
  group('basic', () {
    test('setting bindValue sets value', () {
      IronInput input = fixture('basic');
      input.bindValue = 'foobar';
      expect(input.value, input.bindValue, reason: 'value equals to bindValue');
    });

    test('changing the input triggers an event', () {
      var done = new Completer();
      IronInput input = fixture('basic');
      input.on['bind-value-changed'].take(1).listen((value) {
        expect(input.value, input.bindValue,
            reason: 'value equals to bindValue');
        done.complete();
      });

      input.value = "foo";
      input.jsElement.callMethod('_onInput');
      return done.future;
    });

    test('default value sets bindValue', () {
      IronInput input = fixture('has-value');
      expect(input.bindValue, input.value, reason: 'bindValue equals value');
    });

    test('default bindValue sets value', () {
      IronInput input = fixture('has-bind-value');
      expect(input.value, input.bindValue, reason: 'value equals to bindValue');
    });

    test('set bindValue to undefined', () {
      var scope = new JsObject.fromBrowserObject(
          document.getElementById('bind-to-object'));
      scope['foo'] = null;
      expect(scope[r'$']['input'].bindValue, isNull,
          reason: 'bindValue is falsy');
      expect(scope[r'$']['input'].value, isEmpty, reason: 'value is falsy');
    });

    test('validator used instead of constraints api if provided', () {
      IronInput input = fixture('has-validator')[1];
      input.value = '123';
      input.validate();
      expect(input.invalid, isTrue, reason: 'input is invalid');
    });

    test('prevent invalid input works in _onInput', () {
      IronInput input = fixture('prevent-invalid-input');
      input.value = '123';
      input.jsElement.callMethod('_onInput');
      expect(input.bindValue, '123');
      input.value = '123foo';
      input.jsElement.callMethod('_onInput');
      expect(input.bindValue, '123');
    });
  });
}
