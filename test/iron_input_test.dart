// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@TestOn('browser')
library polymer_elements.test.iron_input_test;

import 'dart:async';
import 'dart:html';
import 'dart:js';
import 'package:polymer/polymer.dart';
import 'package:polymer_elements/iron_input.dart';
import 'package:test/test.dart';
import 'package:web_components/web_components.dart';
import 'fixtures/disabled_input.dart';
import 'common.dart';

main() async {
  await initPolymer();
  var x = 'hello';

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
        expect(input.value, input.bindValue, reason: 'value equals to bindValue');
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
      DomBind scope = document.getElementById('bind-to-object');
      scope['foo'] = null;
      expect(scope.$['input'].bindValue, isNull, reason: 'bindValue is falsy');
      expect(scope.$['input'].value, isEmpty, reason: 'value is falsy');
    });

    test('can validate using a complex regex', () {
      var input = fixture('no-validator');
      input.value = '123';
      input.validate();
      expect(input.invalid, isTrue, reason: 'input is invalid');
      input.value = 'foo';
      input.validate();
      expect(input.invalid, isFalse, reason: 'input is valid');
      input.value = 'foo123';
      input.validate();
      expect(input.invalid, isFalse, reason: 'input is valid');
    });

    test('set bindValue to false', () {
      var scope = document.getElementById('bind-to-object');
      scope['foo'] = false;
      expect(scope.$['input'].jsElement['bindValue'], isFalse);
      expect(scope.$['input'].value, 'false');
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

    test('inputs can be validated', () {
      var input = fixture('prevent-invalid-input-with-pattern');
      input.value = '123';
      input.jsElement.callMethod('_onInput');
      expect(input.bindValue, '123');
      input.validate();
      expect(input.invalid, isTrue, reason: 'input is invalid');

      input.value = 'foo';
      input.jsElement.callMethod('_onInput');
      expect(input.bindValue, 'foo');
      input.validate();
      expect(input.invalid, isFalse, reason: 'input is valid');

      input.value = 'foo123';
      input.jsElement.callMethod('_onInput');
      expect(input.bindValue, 'foo123');
      input.validate();
      expect(input.invalid, isFalse, reason: 'input is valid');
    });

    test('prevent invalid input works automatically when allowed pattern is set', () {
      var input = fixture('automatically-prevent-invalid-input-if-allowed-pattern');
      input.value = '123';
      input.jsElement.callMethod('_onInput');
      expect(input.bindValue, '123');

      input.value = '123foo';
      input.jsElement.callMethod('_onInput');
      expect(input.bindValue, '123');

      input.allowedPattern = '';
      input.value = '#123foo BAR!';
      input.jsElement.callMethod('_onInput');
      expect(input.bindValue, '#123foo BAR!');

      input.allowedPattern = '[a-zA-Z]';
      input.value = 'foo';
      input.jsElement.callMethod('_onInput');
      input.value = 'bar123';
      input.jsElement.callMethod('_onInput');
      expect(input.bindValue, 'foo');
    });

    test('disabled input doesn\'t throw on Firefox', () {
      DisabledInput el = fixture('disabled-input');
      IronInput input = el.$['input'];

      expect(input.bindValue, 'foo');

      expect(el.myInvalid, isFalse);
      expect(input.disabled, isTrue);
    });

    test('browser validation beats custom validation', () {
      IronInput input = fixture('native-and-custom-validator')[1];
      // The input allows any letters, but the browser only allows one
      // of [abc].
      input.value = 'aaaa';
      input.validate();
      expect(input.invalid, isFalse, reason: 'input is valid');

      // The validator allows this, but the browser doesn't.
      input.value = 'zzz';
      input.validate();
      expect(input.invalid, isTrue, reason: 'input is invalid');
    });
  });

  group('a11y', () {
    test('announces invalid characters when _onInput is called', () {
      IronInput input = fixture('prevent-invalid-input');
      input.on['iron-announce'].listen((event) {
        CustomEventWrapper ce = new CustomEventWrapper(event);
        expect(ce.detail["text"], 'Invalid string of characters not entered.');
      });
      input.value = 'foo';
      input.jsElement.callMethod("_onInput");
    });

    test('announces invalid characters on keypress', () {
      IronInput input = fixture('prevent-invalid-input');
      input.on['iron-announce'].listen((event) {
        CustomEventWrapper ce = new CustomEventWrapper(event);
        expect(ce.detail['text'], 'Invalid character a not entered.');
      });

      // Simulate key press event.
      var event = new CustomEvent('keypress', canBubble: true, cancelable: true);
      new JsObject.fromBrowserObject(event)["charCode"] = 97 /* a */;
      input.dispatchEvent(event);
    });
  });
}
